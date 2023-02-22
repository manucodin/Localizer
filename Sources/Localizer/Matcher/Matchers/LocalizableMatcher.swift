//
//  LocalizableMatcher.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 17/2/23.
//

import Foundation

public class LocalizableMatcher: Matchable {
    private let localizablesDataSource: LocalizablesDataSource
    
    public init(parameters: Parameters, configuration: Configuration = .default) {
        self.localizablesDataSource = LocalizablesDataSourceImp(parameters: parameters, configuration: configuration)
    }
    
    public func match() async throws {
        try await localizablesDataSource.compare()
    }
}
