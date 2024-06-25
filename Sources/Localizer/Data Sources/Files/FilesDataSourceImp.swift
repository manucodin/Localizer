//
//  FilesDataSourceImp.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 17/2/23.
//

import Foundation
import Files

class FilesDataSourceImp: FilesDataSource {
    var currentFolder: String {
        return Folder.current.path
    }
    
    func fetchFolders(fromPath path: String) throws -> Set<String> {
        do {
            let folders = try Folder(path: path).subfolders.map{ $0.path }
            return Set<String>(folders)
        } catch let error {
            throw error
        }
    }
    
    func fetchRecursiveFiles(fromPath path: String, extensions: Set<String>) throws -> Set<String> {
        do {
            let folders = try Folder(path: path).subfolders.recursive
            let filesPaths = folders.flatMap { folder in
                let files = folder.files.filter{ extensions.contains($0.extension ?? "" )}
                return files.map{ $0.path }
            }
            return Set<String>(filesPaths)
        } catch let error {
            throw error
        }
    }

    func fetchFileContent(fromPath path: String) throws -> String {
        do {
            return try File(path: path).readAsString()
        } catch let error {
            throw error
        }
    }
    
    func fetchFileData(fromPath path: String) throws -> Data {
        do {
            return try File(path: path).read()
        } catch let error {
            throw error
        }
    }
}
