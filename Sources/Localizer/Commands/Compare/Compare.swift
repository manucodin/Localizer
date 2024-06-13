//
//  Compare.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 22/2/23.
//

import Foundation
import ArgumentParser

struct Compare: AsyncParsableCommand, LocalizerCommand {
    static var configuration = CommandConfiguration(
        abstract: "Search unlocalized strings"
    )
    
    @Option(name: .shortAndLong, help: "Localize strings file path")
    var localizableFilePath: String
    
    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "Paths to search strings localizables")
    var searchPaths: [String]
    
    @Flag(name: .shortAndLong, help: "Show unlocalized keys")
    var unlocalizedKeys: Bool = false
    
    @Flag(name: .shortAndLong, help: "Show all output or only the strings unlocalizable number")
    var verbose: Bool = false
    
    mutating func run() async throws {
        do {
            try await LocalizableMatcher().compare(buildParameters())
            print("Success".green)
        } catch let error {
            handleError(error)
        }
    }
    
    func buildParameters() -> CompareParameters {
        return CompareParameters(localizableFilePath: localizableFilePath, searchPaths: searchPaths, unlocalizedKeys: unlocalizedKeys, verbose: verbose)
    }
}
