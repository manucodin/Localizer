//
//  LocalizablesResult.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 21/2/23.
//

import Foundation

struct LocalizablesResult {
    let languageCode: String
    let localizables: Set<LocalizableValue>
    
    init(languageCode: String, localizables: Set<LocalizableValue>) {
        self.languageCode = languageCode
        self.localizables = localizables
    }
}
