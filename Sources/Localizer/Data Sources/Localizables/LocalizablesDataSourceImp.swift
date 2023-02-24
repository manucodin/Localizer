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
        let languagesPath = try await self.fetchLanguagesPaths()
        let languagesLocalizables = try await self.fetchLocalizables(forLanguagesPaths: languagesPath)
        let projectLocalizables = try await self.projectDataSource.fetchLocalizables()
        
        var unlocalizableKeys = Set<String>()
        
        projectLocalizables.forEach { projectLocalizable in
            languagesLocalizables.forEach { languageLocalizable in
                if !languageLocalizable.localizables.contains(projectLocalizable) {
                    unlocalizableKeys.insert(projectLocalizable)
                    if parameters.verbose {
                        print("Not found \"\(projectLocalizable)\" for \(languageLocalizable.languageCode) language")
                    }
                }
            }
        }
        
        if !unlocalizableKeys.isEmpty {
            throw LocalizerError.unlocalizedStrings(totalUnlocalized: unlocalizableKeys.count)
        }        
    }
    
    private func fetchLanguagesPaths() async throws -> Set<String> {
        return try filesDataSource.fetchFolders(fromPath: parameters.localizableFilePath).filter{ $0.contains(".lproj") }
    }
    
    private func fetchLocalizables(forLanguagesPaths languagesPath: Set<String>) async throws -> [LocalizablesResult] {
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
    
    private func fetchLocalizableKeys(localizableFile filePath: String) async throws -> LocalizablesResult {
        guard let languageCodeValue = URL(string: filePath)?.lastPathComponent.split(separator: ".").first else {
            throw NSError(domain: "test", code: 0)
        }
        
        let languageCode = String(languageCodeValue)
        
        let fileContent = try? filesDataSource.fetchFileContent(
            fromPath: "\(filePath)Localizable.strings",
            encoding: configuration.fileEncoding
        )
        
        guard let fileContent else {
            print("Not found localizables for \(languageCode)".red)
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
}
