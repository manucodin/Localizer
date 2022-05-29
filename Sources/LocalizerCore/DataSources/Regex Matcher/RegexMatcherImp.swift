//
//  File.swift
//  
//
//  Created by Manuel Rodriguez on 29/5/22.
//

import Foundation

class RegexMatcherImp: RegexMatcher {
    
//    private let regexPattern = #"NSLocalizedString\(@?"(\w+)"#
    private let regexPattern = #"/"(?:\.|(\\\")|[^\""\n])*"/g"#
    
    private let fileDataSource: FileDataSource
    private let configuration: Configuration
    
    init(fileDataSource: FileDataSource = FileDataSourceImp(), configuration: Configuration) {
        self.fileDataSource = fileDataSource
        self.configuration = configuration
    }
    
    func fetchLocalizableKeys(fromFile file: String) -> Set<LocalizableString> {
        guard let fileContent = loadFile(filePath: file) else { return Set<LocalizableString>() }
        
        return searchLocalizables(inFileContent: fileContent)
    }
    
    private func loadFile(filePath: String) -> String? {
        guard let fileContent = fileDataSource.fetchFileContent(fromPath: filePath, encoding: configuration.fileEncoding) else { return nil }
        
        return fileContent
    }
    
    private func searchLocalizables(inFileContent fileContent: String) -> Set<LocalizableString> {
        guard let regex = try? NSRegularExpression(pattern: regexPattern) else { return Set<LocalizableString>() }
        
        let fileRange = NSRange(fileContent.startIndex..<fileContent.endIndex, in: fileContent)
        let regexMatches = regex.matches(in: fileContent, range: fileRange)
        debugPrint(regexMatches)
        
        return Set<LocalizableString>()
        
//        if let contentFile = String(data: file, encoding: .utf8){
//            let regex = try NSRegularExpression(pattern: regexPattern, options: [])
//            let range = NSRange(contentFile.startIndex..<contentFile.endIndex, in: contentFile)
//            let results = regex.matches(in: contentFile, options: [], range: range)
//
//            var fileKeys = [String]()
//
//            results.forEach{result in
//                let range = result.range(at: 1)
//                if let swiftRange = Range(range, in: contentFile) {
//                    let key = contentFile[swiftRange]
//                    fileKeys.append(String(key))
//                }
//            }
//
//            return fileKeys
//
//        }
//        return [String]()
    }
    
    //
    //    private func searchLocalizableKeys(inFile file :Data) throws -> [String] {
    //        if let contentFile = String(data: file, encoding: .utf8){
    //            let regex = try NSRegularExpression(pattern: regexExpresion, options: [])
    //            let range = NSRange(contentFile.startIndex..<contentFile.endIndex, in: contentFile)
    //            let results = regex.matches(in: contentFile, options: [], range: range)
    //
    //            var fileKeys = [String]()
    //
    //            results.forEach{result in
    //                let range = result.range(at: 1)
    //                if let swiftRange = Range(range, in: contentFile) {
    //                    let key = contentFile[swiftRange]
    //                    fileKeys.append(String(key))
    //                }
    //            }
    //
    //            return fileKeys
    //
    //        }
    //        return [String]()
    //    }
            
        
    //    func compareKeys(mainKeys :[LocalizableKey], secondaryKeys :[LocalizableKey]) -> [LocalizableKey]{
    //        var results = [LocalizableKey]()
    //        mainKeys.forEach{mainKey in
    //            let newKey = LocalizableKey(key: mainKey.key, path: mainKey.path, inUse: secondaryKeys.contains(where: {$0.key == mainKey.key}))
    //            results.append(newKey)
    //        }
    //
    //        return results
    //    }
}
