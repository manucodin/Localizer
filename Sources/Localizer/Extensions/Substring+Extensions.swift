//
//  Substring+Extensions.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 20/2/23.
//

import Foundation

extension Substring {
    var cleanned: String {
        return trimmingCharacters(in: ["("," ",":","\""])
    }
}
