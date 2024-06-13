//
//  Parameters.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 13/6/24.
//

import Foundation

protocol Parameters {
    var localizableFilePath: String { get }
    var searchPaths: [String] { get }
    var verbose: Bool { get }
}
