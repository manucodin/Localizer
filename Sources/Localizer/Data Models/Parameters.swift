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
    
    public init(localizableFilePath: String, searchPaths: [String]) {
        self.localizableFilePath = localizableFilePath
        self.searchPaths = searchPaths
    }
}
