//
//  RegexMatcher.swift
//  
//
//  Created by Manuel Rodriguez on 29/5/22.
//

import Foundation

protocol RegexMatcher {
    func fetchLocalizableKeys(fromFile filePath: String) -> Set<LocalizableString>
}
