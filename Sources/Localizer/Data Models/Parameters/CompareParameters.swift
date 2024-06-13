//
//  Parameters.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 17/2/23.
//

import Foundation

struct CompareParameters: Parameters {
    let localizableFilePath: String
    let searchPaths: [String]
    let unlocalizedKeys: Bool
    let verbose: Bool
    
    init(localizableFilePath: String, searchPaths: [String], unlocalizedKeys: Bool, verbose: Bool) {
        self.localizableFilePath = localizableFilePath
        self.searchPaths = searchPaths
        self.unlocalizedKeys = unlocalizedKeys
        self.verbose = verbose
    }
}
