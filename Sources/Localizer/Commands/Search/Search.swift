//
//  Search.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 13/6/24.
//

import Foundation
import ArgumentParser

struct Search: AsyncParsableCommand, LocalizerCommand {
    static var configuration = CommandConfiguration(
        abstract: "Search localizable"
    )
    
    @Option(name: .shortAndLong, help: "Localize strings file path")
    var localizableFilePath: String
    
    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "Paths to search strings localizables")
    var searchPaths: [String]
    
    @Option(name: .shortAndLong, help: "Localizable to search")
    var localizable: String = ""
    
    @Flag(name: .shortAndLong, help: "Show unused keys")
    var unusedKeys: Bool = false
    
    @Flag(name: .shortAndLong, help: "Show all output or only the strings unlocalizable number")
    var verbose: Bool = false
    
    mutating func run() async throws {
        do {
            try await LocalizableMatcher().search(buildParameters())
        } catch let error {
            handleError(error)
        }
    }
    
    func buildParameters() -> SearchParameters {
        return SearchParameters(localizableFilePath: localizableFilePath, searchPaths: searchPaths, localizable: localizable, unusedKeys: unusedKeys, verbose: verbose)
    }
}
