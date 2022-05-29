//
//  FilesConfigImp.swift
//  
//
//  Created by Manuel Rodriguez on 24/5/22.
//

import Foundation

struct ConfigurationImp: Configuration {
    let localizableEncoding: String.Encoding
    let fileEncoding: String.Encoding
    let filesSupported: [ExtensionSupported]
    let fileRegexPatterns: [String]
    
    init(localizableEncoding: String.Encoding, fileEncoding: String.Encoding, filesSupported: [ExtensionSupported], fileRegexExpressions: [String]) {
        self.localizableEncoding = localizableEncoding
        self.fileEncoding = fileEncoding
        self.filesSupported = filesSupported
        self.fileRegexPatterns = fileRegexExpressions
    }
}
