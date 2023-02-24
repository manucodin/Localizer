//
//  Parameters.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 17/2/23.
//

import Foundation

public struct Parameters {
    public let localizableFilePath: String
    public let searchPaths: [String]
    public let verbose: Bool
    
    public init(localizableFilePath: String, searchPaths: [String], verbose: Bool) {
        self.localizableFilePath = localizableFilePath
        self.searchPaths = searchPaths
        self.verbose = verbose
    }
}
