//
//  FileDataSource.swift
//  
//
//  Created by Manuel Rodriguez on 24/5/22.
//

import Foundation

protocol FileDataSource {
    func fetchFileContent(fromPath filePath: String, encoding: String.Encoding) -> String?
}
