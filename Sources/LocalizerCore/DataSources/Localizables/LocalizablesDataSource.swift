//
//  LocalizablesDataSource.swift
//  
//
//  Created by Manuel Rodriguez on 24/5/22.
//

import Foundation

protocol LocalizablesDataSource {
    func fetchLocalizableKeys(fromFile filePath :String) -> Set<LocalizableString>
}
