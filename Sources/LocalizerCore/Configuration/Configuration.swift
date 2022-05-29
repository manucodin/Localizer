//
//  FilesConfig.swift
//  
//
//  Created by Manuel Rodriguez on 24/5/22.
//

import Foundation

protocol Configuration {
    var localizableEncoding: String.Encoding { get }
    var fileEncoding: String.Encoding { get }
    var filesSupported :[ExtensionSupported] { get }
    var fileRegexPatterns: [String] { get }
}
