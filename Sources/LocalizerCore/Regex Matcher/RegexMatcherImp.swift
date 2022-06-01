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
    
    func fetchLocalizableKeys(fromFile filePath: String) -> Set<LocalizableString> {
        guard let fileContent = fileDataSource.fetchFileContent(fromPath: filePath, encoding: configuration.fileEncoding) else { return Set<LocalizableString>() }
        guard let regexPattern = configuration.fileRegexPatterns.first else { return Set<LocalizableString>() }
        
        return searchLocalizables(inFileContent: fileContent, regexPattern: regexPattern)
    }

    private func searchLocalizables(inFileContent fileContent: String, regexPattern: String) -> Set<LocalizableString> {
        guard let regex = try? NSRegularExpression(pattern: regexPattern, options: .caseInsensitive) else { return Set<LocalizableString>() }
        
        let range = NSRange(fileContent.startIndex..<fileContent.endIndex, in: fileContent)
        let regexMatches = regex.matches(in: fileContent, options: [], range: range)
        
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
