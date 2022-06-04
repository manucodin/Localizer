import Foundation

class RegexMatcherImp: RegexMatcher {
    private let fileDataSource: FileDataSource
    private let configuration: Configuration
    
    init(fileDataSource: FileDataSource = FileDataSourceImp(), configuration: Configuration) {
        self.fileDataSource = fileDataSource
        self.configuration = configuration
    }
    
    func fetchLocalizableKeys(fromFile filePath: String) -> Set<String> {
        guard let fileContent = fileDataSource.fetchFileContent(fromPath: filePath, encoding: configuration.fileEncoding) else { return Set<String>() }
        guard let regexPattern = configuration.fileRegexPatterns.first else { return Set<String>() }
        
        return searchLocalizables(inFileContent: fileContent, regexPattern: regexPattern)
    }

    private func searchLocalizables(inFileContent fileContent: String, regexPattern: String) -> Set<String> {
        guard let regex = try? NSRegularExpression(pattern: regexPattern, options: .caseInsensitive) else { return Set<String>() }
                
        let range = NSRange(fileContent.startIndex..<fileContent.endIndex, in: fileContent)
        let regexMatches = regex.matches(in: fileContent, options: [], range: range)
                
        let localizablesString = regexMatches.compactMap{ regexResult -> String? in
            if let range = Range(regexResult.range, in: fileContent) {
                return String(fileContent[range].clean())
            }

            return nil
        }
        
        return Set<String>(localizablesString)
    }
}
