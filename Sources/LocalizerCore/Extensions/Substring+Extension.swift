//
//  Substring+Extension.swift
//  
//
//  Created by Manuel Rodriguez on 29/5/22.
//

import Foundation

extension Substring {
    func clean() -> String {
        return self.trimmingCharacters(in: ["("," ",":","\"",")"])
    }
}
