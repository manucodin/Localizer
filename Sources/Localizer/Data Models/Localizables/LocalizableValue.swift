//
//  File.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 6/9/23.
//

import Foundation

public struct LocalizableValue: Hashable {
    public let key: String
    public let value: String
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
