//
//  String+Extensions.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 20/2/23.
//

import Foundation

extension String {
    var isEndOfLocalizable: Bool {
        guard let lastChracter = last else { return false }
        guard lastChracter == ";" else { return false }
        
        return true
    }
    
    var localizableKey: String? {
        return split(separator: "=").first?.cleanned
    }
}
