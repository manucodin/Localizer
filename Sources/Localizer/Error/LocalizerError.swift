//
//  LocalizerError.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 21/2/23.
//

import Foundation

enum LocalizerError: Error {
    case invalidPath(path: String)
    case invalidParams(expectedType: Parameters.Type, currentType: Parameters.Type)
    
    case unlocalizedStrings(totalUnlocalized: Int)
    case unlocalizedStringsWithMessage(message: String)
    
    case unusedStrings(totalUnusedKeys: Int)
    case unusedStringsWithMessage(message: String)
    
    var description: String {
        switch self {
        case .invalidPath(let path): 
            return "Invalid path for: \(path)"
        case .invalidParams(let expectedType, let currentType):
            return "Expected \(String(describing: expectedType.self)), current parameters are: \(String(describing: currentType.self))"
        case .unlocalizedStrings(let totalUnlocalized):
            return "Unlocalized strings: \(totalUnlocalized)"
        case .unlocalizedStringsWithMessage(let message): 
            return message
        case .unusedStrings(let totalUnusedKeys): 
            return "Unused strings: \(totalUnusedKeys)"
        case .unusedStringsWithMessage(let message): 
            return message
        }
    }
}
