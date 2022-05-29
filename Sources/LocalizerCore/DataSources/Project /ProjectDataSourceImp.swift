//
//  ProjectDataSourceImp.swift
//  
//
//  Created by Manuel Rodriguez on 27/5/22.
//

import Foundation
import Files

class ProjectDataSourceImp: ProjectDataSource {
    private let configuration: Configuration
    private let regexMatcher: RegexMatcher
    
    init(configuration: Configuration) {
        self.configuration = configuration
        self.regexMatcher = RegexMatcherImp(configuration: configuration)
    }
    
    func fetchLocalizables(fromPath path: String) -> Set<LocalizableString> {
        let localizableKeys = fetchLocalizableKeys(fromPath: path)
        return localizableKeys
    }
    
    private func fetchLocalizableKeys(fromPath path: String) -> Set<LocalizableString> {
        var localizableKeys = Set<LocalizableString>()
        
        let files = fetchFiles(fromPath: path)
        
        files.forEach{ file in
            let fileLocalizables = regexMatcher.fetchLocalizableKeys(fromFile: file.path)
            fileLocalizables.forEach{ localizableKeys.insert($0) }
        }
        
        return localizableKeys
    }
    
    private func fetchFiles(fromPath path: String) -> [File] {
        guard let folder = fetchFolder(fromPath: path) else { return [] }
        
        let subFolders = folder.subfolders.recursive
        let files = subFolders.flatMap{ $0.files.filter{ $0.isSupported(extensionsSupported: configuration.filesSupported) } }
            
        return files
    }
    
    private func fetchFolder(fromPath path: String) -> Folder? {
        guard let folder = try? Folder(path: path) else { return nil }
        
        return folder
    }
}
