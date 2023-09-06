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
            return LocalizablesResult(languageCode: languageCode, localizables: Set<LocalizableValue>())
        }
        
        let fileRange = NSRange(fileContent.startIndex..<fileContent.endIndex, in: fileContent)
        let captureRegex = try NSRegularExpression(
            pattern: configuration.localizablesPattern,
            options: .caseInsensitive
        )
        
        let matches = captureRegex.matches(in: fileContent, range: fileRange)
        
        var results = Set<LocalizableValue>()
        matches.forEach { match in
            for rangeIndex in 1..<match.numberOfRanges {
                guard match.numberOfRanges > 2  && rangeIndex == 1 else { continue }
                    
                let keyRange = match.range(at: rangeIndex)
                let valueRange = match.range(at: rangeIndex+1)
                
                if keyRange == fileRange { continue }

                if let substringKeyRange = Range(keyRange, in: fileContent), let substringValueRange = Range(valueRange, in: fileContent){
                    let key = String(fileContent[substringKeyRange])
                    let value = String(fileContent[substringValueRange])
                    
                    let localizableValue = LocalizableValue(key: key, value: value)
                    results.insert(localizableValue)
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
                let message = "\(unlocalizableKeys.joined(separator: "\n"))\nUnlocalized strings: \(unlocalizableKeys.count)"
                throw LocalizerError.unlocalizedStringsWithMessage(message: message)
            } else {
                throw LocalizerError.unlocalizedStrings(totalUnlocalized: unlocalizableKeys.count)
            }
        }
    }
    
    private func isUnlocalized(key: String, languageLocalizables: Set<LocalizableValue>, whiteList: Set<String>) -> Bool {
        let notIgnoredKey = !whiteList.contains(key)
        let isUnlocalizedKey = !languageLocalizables.contains(where: { $0.key == key })
        
        if let value = languageLocalizables.first(where: { $0.key == key })?.value, value.isEmpty {
            return true
        }
        
        return notIgnoredKey && isUnlocalizedKey
    }
}
