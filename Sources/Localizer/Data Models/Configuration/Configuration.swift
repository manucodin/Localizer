//
//  Configuration.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 21/2/23.
//

import Foundation

public struct Configuration {
    public let localizableEncoding: String.Encoding
    public let fileEncoding: String.Encoding
    public let formatsSupported: Set<String>
    public let capturePattern: String
    public let localizablesPattern: String
    
    public static var `default`: Configuration {
        return Configuration(
            localizableEncoding: .utf8,
            fileEncoding: .utf8,
            formatsSupported: [.swift, .objC],
            capturePattern: #"(?:.*\"(.*)\".localized)|NSLocalizedString\(\s*"([^"]+)"(?:\s*,|\s*comment:\s*"[^"]*"\s*\))"#,
            localizablesPattern: #"\"(.*)\".* ?="#
        )
    }

    private init(localizableEncoding: String.Encoding, fileEncoding: String.Encoding, formatsSupported: [FormatsSupported], capturePattern: String, localizablesPattern: String) {
        self.localizableEncoding = localizableEncoding
        self.fileEncoding = fileEncoding
        self.formatsSupported = Set<String>(formatsSupported.map{ $0.rawValue })
        self.capturePattern = capturePattern
        self.localizablesPattern = localizablesPattern
    }
}
