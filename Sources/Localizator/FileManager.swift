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
    
    public func readFile(filePath :String) throws -> Data{
        let fileURL = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: fileURL)
        return data
    }
    
    public func localizableKeys(inPath path :String) throws -> [LocalizableKey]{
        let file = try File(path: path)
        let fileContent = try file.readAsString(encodedAs: .unicode)
        return seeker.searchKeysInLocalizable(fileContent: fileContent)
    }
    
    public func searchLocalizableKeys(inDirectoryPath path :String) throws -> [LocalizableKey]{
        let folder = try Folder(path: path)
                
        var proyectKeys = [LocalizableKey]()
        
        try folder.subfolders.recursive.forEach{folder in
            let files = folder.files.filter{file in
                guard let fileExtension = file.extension else{
                    return false
                }
                
                //TODO: - Convertir a configuración
                if(fileExtension == "swift" || fileExtension == "m"){
                    return true
                }
    
                return false
            }
            
            try files.forEach{
                let keys = try seeker.searchLocalizableKeys(inFile: $0.read()).map({LocalizableKey(key: $0)})
                proyectKeys.append(contentsOf: keys)
            }
        }
        
        return proyectKeys
    }
    
    public func compareKeys(mainKeys :[LocalizableKey], secondaryKeys :[LocalizableKey]) -> [LocalizableKey]{
        return seeker.compareKeys(mainKeys: mainKeys, secondaryKeys: secondaryKeys)
    }
}
