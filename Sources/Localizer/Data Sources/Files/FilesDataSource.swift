//
//  FilesDataSource.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 17/2/23.
//

import Foundation
import Files

internal protocol FilesDataSource {
    var currentFolder: String { get }
    func fetchFolders(fromPath path: String) throws -> Set<String>
    func fetchRecursiveFiles(fromPath path: String, extensions: Set<String>) throws -> Set<String>
    func fetchFileContent(fromPath path: String) throws -> String
    func fetchFileData(fromPath path: String) throws -> Data
}
