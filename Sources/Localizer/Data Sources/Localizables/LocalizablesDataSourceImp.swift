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
                    print("Not found \"\(projectLocalizable)\" for \(languageLocalizable.languageCode) language")
                }
            }
        }
        
        if !unlocalizableKeys.isEmpty {
            throw LocalizerError.unlocalizedStrings(totalUnlocalized: unlocalizableKeys.count)
        }        
    }
    
    private func fetchLanguagesPaths() async throws -> Set<String> {
        return try filesDataSource.fetchFolders(fromPath: parameters.localizableFilePath)
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
        guard let languageCode = URL(string: filePath)?.lastPathComponent.split(separator: ".").first else {
            throw NSError(domain: "test", code: 0)
        }
        
        let fileContent = try filesDataSource.fetchFileContent(
            fromPath: "\(filePath)Localizable.strings",
            encoding: configuration.fileEncoding
        )
        
        let localizableKey = fileContent.components(separatedBy: .newlines).compactMap { stringValue -> String? in
            guard stringValue.isEndOfLocalizable else { return nil }
            return stringValue.localizableKey
        }
        
        return LocalizablesResult(languageCode: String(languageCode), localizables: Set<String>(localizableKey))
    }
}
