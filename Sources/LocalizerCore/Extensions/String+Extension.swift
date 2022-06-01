//
//  String+Extension.swift
//  
//
//  Created by Manuel Rodriguez on 29/5/22.
//

import Foundation

extension String {
    func clean() -> String {
        return self.trimmingCharacters(in: ["("," ",":","\"",")","\n","\\"])
    }
}
