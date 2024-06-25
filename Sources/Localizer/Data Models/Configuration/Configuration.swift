//
//  Configuration.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 21/2/23.
//

import Foundation

struct Configuration {
    let formatsSupported: Set<String>
    let capturePattern: String
    let localizablesPattern: String
    let whitelistPattern: String
    
    static var `default`: Configuration {
        return Configuration(
            formatsSupported: [.swift, .objC],
            capturePattern: #"\"([^"\\]*(?:\\.[^"\\]*)*)\".localized|NSLocalizedString\(\s*"([^"]+)"(?:\s*,|\s*comment:\s*"[^"]*"\s*\))"#,
            localizablesPattern: #"\"(.*)\".*\s*?=\s*\"(.*)\""#,
            whitelistPattern: #"\"([^"\\]*(?:\\.[^"\\]*)*)\""#
        )
    }
    
    init(formatsSupported: [FormatsSupported], capturePattern: String, localizablesPattern: String, whitelistPattern: String) {
        self.formatsSupported = Set<String>(formatsSupported.map{ $0.rawValue })
        self.capturePattern = capturePattern
        self.localizablesPattern = localizablesPattern
        self.whitelistPattern = whitelistPattern
    }
}
