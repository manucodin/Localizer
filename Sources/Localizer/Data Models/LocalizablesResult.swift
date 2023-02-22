//
//  LocalizablesResult.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 21/2/23.
//

import Foundation

public struct LocalizablesResult {
    public let languageCode: String
    public let localizables: Set<String>
    
    public init(languageCode: String, localizables: Set<String>) {
        self.languageCode = languageCode
        self.localizables = localizables
    }
}
