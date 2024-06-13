//
//  SearchParameters.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 13/6/24.
//

import Foundation

struct SearchParameters: Parameters {
    let localizableFilePath: String
    let searchPaths: [String]
    let localizable: String
    let unusedKeys: Bool
    let verbose: Bool
    
    init(localizableFilePath: String, searchPaths: [String], localizable: String, unusedKeys: Bool, verbose: Bool) {
        self.localizableFilePath = localizableFilePath
        self.searchPaths = searchPaths
        self.localizable = localizable
        self.unusedKeys = unusedKeys
        self.verbose = verbose
    }
}
