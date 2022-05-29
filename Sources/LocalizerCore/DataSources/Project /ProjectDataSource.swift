//
//  ProjectDataSource.swift
//  
//
//  Created by Manuel Rodriguez on 27/5/22.
//

import Foundation

protocol ProjectDataSource {
    func fetchLocalizables(fromPath path: String) -> Set<LocalizableString>
}
