//
//  FilesDataSourceImp.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 17/2/23.
//

import Foundation
import Files

class FilesDataSourceImp: FilesDataSource {
    func fetchFolders(fromPath path: String) throws -> Set<String> {
        do {
            let folders = try Folder(path: path).subfolders.map{ $0.path }
            return Set<String>(folders)
        } catch {
            throw LocalizerError.invalidPath(path: path)
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
        } catch {
            throw LocalizerError.invalidPath(path: path)
        }
    }

    func fetchFileContent(fromPath path: String, encoding: String.Encoding) throws -> String {
        do {
            return try File(path: path).readAsString(encodedAs: encoding)
        } catch {
            throw LocalizerError.invalidPath(path: path)
        }
    }
    
    func fetchFileData(fromPath path: String) throws -> Data {
        do {
            return try File(path: path).read()
        } catch {
            throw LocalizerError.invalidPath(path: path)
        }
    }
}
