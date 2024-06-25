//
//  ProjectDataSource.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 20/2/23.
//

import Foundation

class ProjectDataSourceImp: ProjectDataSource {
    let configuration: Configuration
    
    let filesDataSource: FilesDataSource = FilesDataSourceImp()
    
    init(configuration: Configuration = .default) {
        self.configuration = configuration
    }
    
    func fetchLocalizables(_ searchPaths: [String]) async throws -> Set<String> {
        return try await withThrowingTaskGroup(of: Set<String>.self) { taskGroup in
            searchPaths.forEach { searchablePath in
                taskGroup.addTask {
                    return try await self.fetchLocalizableKeys(
                        fromPath: searchablePath,
                        extensions: self.configuration.formatsSupported,
                        pattern: self.configuration.capturePattern
                    )
                }
            }
            
            var localizablesSearched = Set<String>()
            for try await localizablesResult in taskGroup {
                localizablesSearched = localizablesSearched.union(localizablesResult)
            }
            
            return localizablesSearched
        }
    }
    
    func fetchWhiteListKeys() async throws -> Set<String> {
        let whiteListPath = filesDataSource.currentFolder.appending(".localizerignore")
        return try await searchKeys(whiteListPath, configuration.whitelistPattern)
    }
    
    func fetchLocalizableKeys(fromPath path: String, extensions: Set<String>, pattern: String) async throws -> Set<String> {
        return try await withThrowingTaskGroup(of: Set<String>.self) { taskGroup in
            let files = try filesDataSource.fetchRecursiveFiles(fromPath: path, extensions: extensions)
            
            files.forEach { file in
                taskGroup.addTask {
                    return try await self.searchKeys(file, self.configuration.capturePattern)
                }
            }
            
            var fileLocalizables = Set<String>()
            for try await localizables in taskGroup {
                fileLocalizables = fileLocalizables.union(localizables)
            }
            
            return fileLocalizables
        }
    }
    
    func searchKeys(_ filePath: String, _ capturePattern: String) async throws -> Set<String> {
        guard let fileContent = try? filesDataSource.fetchFileContent(fromPath: filePath) else {
            return Set<String>()
        }
        
        let fileRange = NSRange(fileContent.startIndex..<fileContent.endIndex, in: fileContent)
        let captureRegex = try NSRegularExpression(
            pattern: capturePattern,
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
        
        return results
    }
}
