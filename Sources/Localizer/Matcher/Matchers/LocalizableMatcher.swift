//
//  LocalizableMatcher.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 17/2/23.
//

import Foundation

class LocalizableMatcher: Matchable {
    let localizablesDataSource: LocalizablesDataSource
    
    init(_ localizablesDataSource: LocalizablesDataSource = LocalizablesDataSourceImp()) {
        self.localizablesDataSource = localizablesDataSource
    }
    
    func compare(_ parameters: CompareParameters) async throws {
        try await localizablesDataSource.compare(parameters)
    }
    
    func search(_ parameters: SearchParameters) async throws {
        try await localizablesDataSource.search(parameters)
    }
}
