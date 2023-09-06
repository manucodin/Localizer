//
//  Configuration.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 21/2/23.
//

import Foundation

public struct Configuration {
    public let formatsSupported: Set<String>
    public let capturePattern: String
    public let localizablesPattern: String
    public let whitelistPattern: String
    
    public static var `default`: Configuration {
        return Configuration(
            formatsSupported: [.swift, .objC],
            capturePattern: #"\"([^"\\]*(?:\\.[^"\\]*)*)\".localized|NSLocalizedString\(\s*"([^"]+)"(?:\s*,|\s*comment:\s*"[^"]*"\s*\))"#,
            localizablesPattern: #"\"(.*)\".* ?= \"(.*)\""#,
            whitelistPattern: #"\"([^"\\]*(?:\\.[^"\\]*)*)\""#
        )
    }
    
    private init(formatsSupported: [FormatsSupported], capturePattern: String, localizablesPattern: String, whitelistPattern: String) {
        self.formatsSupported = Set<String>(formatsSupported.map{ $0.rawValue })
        self.capturePattern = capturePattern
        self.localizablesPattern = localizablesPattern
        self.whitelistPattern = whitelistPattern
    }
}
