//
//  String+Extensions.swift
//  LocalizerExampleProject
//
//  Created by Manuel Rodriguez Sebastian on 21/2/23.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
