//
//  File.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 6/9/23.
//

import Foundation

struct LocalizableValue: Hashable {
    let key: String
    let value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
