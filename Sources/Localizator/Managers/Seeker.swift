//
//  Seeker.swift
//  
//
//  Created by Manuel Rodríguez Sebastián on 02/07/2020.
//

import Foundation

class Seeker{
    
    private let regexExpresion = #"NSLocalizedString\(@?"(\w+)"#
       
    func searchLocalizableKeys(inFile file :Data) throws -> [String]{
        if let contentFile = String(data: file, encoding: .utf8){
            let regex = try NSRegularExpression(pattern: regexExpresion, options: [])
            let range = NSRange(contentFile.startIndex..<contentFile.endIndex, in: contentFile)
            let results = regex.matches(in: contentFile, options: [], range: range)
            
            var fileKeys = [String]()
            
            results.forEach{result in
                let range = result.range(at: 1)
                if let swiftRange = Range(range, in: contentFile) {
                    let key = contentFile[swiftRange]
                    fileKeys.append(String(key))
                }
            }
            
            return fileKeys
        
        }
        return [String]()
    }
    
    func searchKeysInLocalizable(fileContent :String, path :String) -> [LocalizableKey]{
        let lines = fileContent.components(separatedBy: .newlines).filter{
            guard let lastChracter = $0.last else{
                return false
            }
            if(lastChracter == ";"){
                return true
            }
            return false
        }
        
        let keyValues = lines.map({String($0.split(separator: "=").first ?? "")}).map({String($0.replacingOccurrences(of: "\"", with: "").trimmingCharacters(in: .whitespacesAndNewlines))})
        
        let keys = keyValues.map({LocalizableKey(key: $0, path: path)})
        return keys
    }
    
    func compareKeys(mainKeys :[LocalizableKey], secondaryKeys :[LocalizableKey]) -> [LocalizableKey]{
                
        var results = [LocalizableKey]()
        mainKeys.forEach{mainKey in
            let newKey = LocalizableKey(key: mainKey.key, path: mainKey.path, inUse: secondaryKeys.contains(where: {$0.key == mainKey.key}))
            results.append(newKey)
        }
                
        return results
    }
}
