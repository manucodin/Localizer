//
//  LocalizablesDataSourceImp.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 17/2/23.
//

import Foundation
import Rainbow

class LocalizablesDataSourceImp: LocalizablesDataSource {
    let filesDataSource: FilesDataSource
    let projectDataSource: ProjectDataSource
    let configuration: Configuration
    
    init(filesDataSource: FilesDataSource = FilesDataSourceImp(), projectDataSource: ProjectDataSource = ProjectDataSourceImp(), configuration: Configuration = .default) {
        self.filesDataSource = filesDataSource
        self.projectDataSource = projectDataSource
        self.configuration = configuration
    }
    
    func compare(_ parameters: CompareParameters) async throws {
        try await makeCompare(parameters)
    }
    
    func search(_ parameters: SearchParameters) async throws {
        try await makeSearch(parameters)
    }
    
    func makeCompare(_ parameters: CompareParameters) async throws {
        var unlocalizableKeys = Set<String>()
        
        let languagesLocalizables = try await fetchLangugeLocalizables(parameters)
        let projectLocalizables = try await projectDataSource.fetchLocalizables(parameters.searchPaths)
        let whiteListKeys = try await projectDataSource.fetchWhiteListKeys()
        
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
    
    func makeSearch(_ parameters: SearchParameters) async throws {
        let languagesLocalizables = try await fetchLangugeLocalizables(parameters)
        let projectLocalizables = try await projectDataSource.fetchLocalizables(parameters.searchPaths)
        
        let flattedLocalizables = Set<String>(languagesLocalizables.flatMap({ $0.localizables.map({ $0.key }) }))
        let unnusedKeys = flattedLocalizables.symmetricDifference(projectLocalizables)
        
        if !unnusedKeys.isEmpty {
            if parameters.verbose {
                let message = "\(unnusedKeys.joined(separator: "\n"))\nUnnused strings: \(unnusedKeys.count)"
                throw LocalizerError.unusedStringsWithMessage(message: message)
            } else {
                throw LocalizerError.unusedStrings(totalUnusedKeys: unnusedKeys.count)
            }
        }
    }
    
    func fetchLangugeLocalizables(_ parameters: Parameters) async throws -> [LocalizablesResult] {
        let languagePaths = try await fetchLanguagesPaths(parameters)
        return try await fetchLocalizables(languagePaths)
    }
    
    func fetchLanguagesPaths(_ parameters: Parameters) async throws -> Set<String> {
        return try filesDataSource.fetchFolders(fromPath: parameters.localizableFilePath).filter{
            $0.contains(LOCALIZABLE_FILE_EXTENSION)
        }
    }
    
    func fetchLocalizables(_ languagePaths: Set<String>) async throws -> [LocalizablesResult] {
        return try await withThrowingTaskGroup(of: LocalizablesResult.self) { taskGroup in
            languagePaths.forEach { languagePath in
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
    
    func fetchLocalizableKeys(localizableFile filePath: String) async throws -> LocalizablesResult {
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
    
    func isUnlocalized(key: String, languageLocalizables: Set<LocalizableValue>, whiteList: Set<String>) -> Bool {
        let notIgnoredKey = !whiteList.contains(key)
        let isUnlocalizedKey = !languageLocalizables.contains(where: { $0.key == key })
        
        if let value = languageLocalizables.first(where: { $0.key == key })?.value, value.isEmpty {
            return true
        }
        
        return notIgnoredKey && isUnlocalizedKey
    }
}
