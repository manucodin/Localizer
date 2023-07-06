//
//  LocalizablesDataSourceImp.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 17/2/23.
//

import Foundation
import Rainbow

class LocalizablesDataSourceImp: LocalizablesDataSource {
    private let parameters: Parameters
    private let configuration: Configuration
    
    private let filesDataSource: FilesDataSource
    private let projectDataSource: ProjectDataSource
    
    internal init(parameters: Parameters, configuration: Configuration) {
        self.parameters = parameters
        self.configuration = configuration
        self.filesDataSource = FilesDataSourceImp()
        self.projectDataSource = ProjectDataSourceImp(parameters: parameters, configuration: configuration)
    }
    
    func compare() async throws {
        let languagesLocalizables = try await self.fetchLocalizables()
        let projectLocalizables = try await self.projectDataSource.fetchLocalizables()
        let whiteListKeys = try await self.projectDataSource.fetchWhiteListKeys()
        
        try compare(projectLocalizables, languagesLocalizables, whiteListKeys)
    }
    
    internal func fetchLocalizables() async throws -> [LocalizablesResult] {
        let languagesPath = try await self.fetchLanguagesPaths()
        return try await withThrowingTaskGroup(of: LocalizablesResult.self) { taskGroup in
            languagesPath.forEach { languagePath in
                taskGroup.addTask {
                    return try await self.fetchLocalizableKeys(localizableFile: languagePath)
                }
            }
            
            var projectLocalizables = [LocalizablesResult]()
            for try await localizables in taskGroup {
                projectLocalizables.append(localizables)
            }
            
            return projectLocalizables
        }
    }
    
    private func fetchLanguagesPaths() async throws -> Set<String> {
        return try filesDataSource.fetchFolders(fromPath: parameters.localizableFilePath).filter{
            $0.contains(LOCALIZABLE_FILE_EXTENSION)
        }
    }
    
    private func fetchLocalizableKeys(localizableFile filePath: String) async throws -> LocalizablesResult {
        guard let languageCodeValue = URL(string: filePath)?.lastPathComponent.split(separator: ".").first else {
            throw NSError(domain: "test", code: 0)
        }
        
        let languageCode = String(languageCodeValue)
        
        let fileContent: String
        do {
            fileContent = try String(contentsOfFile: "\(filePath)Localizable.strings")
        } catch let error {
            print("Not found localizables for '\(languageCode.uppercased())'. \(error)".red)
            return LocalizablesResult(languageCode: languageCode, localizables: Set<String>())
        }
        
        let fileRange = NSRange(fileContent.startIndex..<fileContent.endIndex, in: fileContent)
        let captureRegex = try NSRegularExpression(
            pattern: configuration.localizablesPattern,
            options: .caseInsensitive
        )
        
        let matches = captureRegex.matches(in: fileContent, range: fileRange)
        
        var results = Set<String>()
        matches.forEach { match in
            for rangeIndex in 1..<match.numberOfRanges {
                let matchRange = match.range(at: rangeIndex)
                
                if matchRange == fileRange { continue }
                
                if let substringRange = Range(matchRange, in: fileContent) {
                    let capture = String(fileContent[substringRange])
                    results.insert(capture)
                }
            }
        }
        
        return LocalizablesResult(languageCode: languageCode, localizables: results)
    }
    
    private func compare(_ projectLocalizables: Set<String>, _ languagesLocalizables: [LocalizablesResult], _ whiteListKeys: Set<String>) throws {
        var unlocalizableKeys = Set<String>()
        
        projectLocalizables.forEach { projectLocalizable in
            languagesLocalizables.forEach { languageLocalizable in
                if isUnlocalized(key: projectLocalizable, languageLocalizables: languageLocalizable.localizables, whiteList: whiteListKeys) {
                    unlocalizableKeys.insert(projectLocalizable)
                    if parameters.verbose {
                        print("Not found \"\(projectLocalizable)\" for '\(languageLocalizable.languageCode.uppercased())' language")
                    }
                }
            }
        }
        
        if !unlocalizableKeys.isEmpty {
            if parameters.unlocalizedKeys {
                let message = unlocalizableKeys.map({ String(format: "Not localized %@", $0)}).joined(separator: "\n")
                throw LocalizerError.unlocalizedStringsWithMessage(message: message, totalUnlocalized: unlocalizableKeys.count)
            } else {
                throw LocalizerError.unlocalizedStrings(totalUnlocalized: unlocalizableKeys.count)
            }
        }
    }
    
    private func isUnlocalized(key: String, languageLocalizables: Set<String>, whiteList: Set<String>) -> Bool {
        let notIgnoredKey = !whiteList.contains(key)
        let isUnlocalizedKey = !languageLocalizables.contains(key)
        
        return notIgnoredKey && isUnlocalizedKey
    }
}
