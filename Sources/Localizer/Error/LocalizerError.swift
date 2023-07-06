//
//  LocalizerError.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 21/2/23.
//

import Foundation

enum LocalizerError: Error {
    case invalidPath(path: String)
    case unlocalizedStrings(totalUnlocalized: Int)
    case unlocalizedStringsWithMessage(message: String, totalUnlocalized: Int)
    
    public var description: String {
        switch self {
        case .invalidPath(let path): return "Invalid path for: \(path)"
        case .unlocalizedStrings(let totalUnlocalized): return "Unlocalized strings: \(totalUnlocalized)"
        case .unlocalizedStringsWithMessage(let message, let totalUnlocalized): return "\(message)\nUnlocalized strings: \(totalUnlocalized)"
        }
    }
}
