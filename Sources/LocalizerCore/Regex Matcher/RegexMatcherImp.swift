//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 29/5/22.
//

import Foundation

class RegexMatcherImp: RegexMatcher {
    private let fileDataSource: FileDataSource
    private let configuration: Configuration
    
    init(fileDataSource: FileDataSource = FileDataSourceImp(), configuration: Configuration) {
        self.fileDataSource = fileDataSource
        self.configuration = configuration
    }
    
    func fetchLocalizableKeys(fromFile file: String) -> Set<LocalizableString> {
        guard let fileContent = loadFile(filePath: file) else { return Set<LocalizableString>() }
        
        var fileLocalizables = Set<LocalizableString>()
        configuration.fileRegexPatterns.forEach{ regexPattern in
            let localizables = searchLocalizables(inFileContent: fileContent, regexPattern: regexPattern)
            fileLocalizables.formUnion(localizables)
        }
        
        return fileLocalizables
    }
    
    private func loadFile(filePath: String) -> String? {
        guard let fileContent = fileDataSource.fetchFileContent(fromPath: filePath, encoding: configuration.fileEncoding) else { return nil }
        
        return fileContent
    }
    
    private func searchLocalizables(inFileContent fileContent: String, regexPattern: String) -> Set<LocalizableString> {
        guard let regex = try? NSRegularExpression(pattern: regexPattern) else { return Set<LocalizableString>() }
        
        let fileRange = NSRange(fileContent.startIndex..<fileContent.endIndex, in: fileContent)
        let regexMatches = regex.matches(in: fileContent, range: fileRange)
        let localizablesString = regexMatches.compactMap{ regexResult -> LocalizableString? in
            if let range = Range(regexResult.range, in: fileContent) {
                let key = String(fileContent[range].clean())
                return LocalizableString(key: key)
            }
            
            return nil
        }
        
        return Set<LocalizableString>(localizablesString)        
    }
}
