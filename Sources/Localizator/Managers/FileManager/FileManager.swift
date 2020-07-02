//
//  FileManager.swift
//  
//
//  Created by Manuel Rodríguez Sebastián on 01/07/2020.
//

import Foundation
import Files

class FileManager{
        
    private let seeker = Seeker()
    
    private let config = FileManagerConfig()
    
    public func readFile(filePath :String) throws -> Data{
        let fileURL = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: fileURL)
        return data
    }
    
    public func localizableKeys(inPath path :String) throws -> [LocalizableKey]{
        let file = try File(path: path)
        let fileContent = try file.readAsString(encodedAs: .unicode)
        return seeker.searchKeysInLocalizable(fileContent: fileContent, path: path)
    }
    
    public func searchLocalizableKeys(inDirectoryPath path :String) throws -> [LocalizableKey]{
        let folder = try Folder(path: path)
                
        var proyectKeys = [LocalizableKey]()
        
        try folder.subfolders.recursive.forEach{folder in
            let files = folder.files.filter{file in
                guard let fileExtension = file.extension else{
                    return false
                }
                
                if(config.extensions.map{$0.rawValue}.contains(fileExtension)){
                    return true
                }
    
                return false
            }
            
            try files.forEach{file in
                let keys = try seeker.searchLocalizableKeys(inFile: file.read()).map({LocalizableKey(key: $0, path: file.path)})
                proyectKeys.append(contentsOf: keys)
            }
        }
        
        return proyectKeys
    }
    
    public func compareKeys(mainKeys :[LocalizableKey], secondaryKeys :[LocalizableKey]) -> [LocalizableKey]{
        return seeker.compareKeys(mainKeys: mainKeys, secondaryKeys: secondaryKeys)
    }
}
