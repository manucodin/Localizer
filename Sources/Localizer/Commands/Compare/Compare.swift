//
//  Compare.swift
//  
//
//  Created by Manuel Rodriguez Sebastian on 22/2/23.
//

import Foundation
import ArgumentParser

struct Compare: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Search unlocalized strings"
    )
    
    @Option(name: .shortAndLong, help: "Localize strings file path")
    private var localizableFilePath: String
    
    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "Paths to search strings localizables")
    private var searchPaths: [String]
    
    @Flag(name: .long, help: "Show unlocalized keys")
    private var unlocalizedKeys: Bool = false
    
    @Flag(name: .long, help: "Show unused keys")
    private var unusedKeys: Bool = false
    
    @Flag(name: .shortAndLong, help: "Show all output or only the strings unlocalizable number")
    private var verbose: Bool = false
    
    mutating func run() async throws {
        let parameters = Parameters(
            localizableFilePath: localizableFilePath,
            searchPaths: searchPaths,
            unlocalizedKeys: unlocalizedKeys,
            unusedKeys: unusedKeys,
            verbose: verbose
        )
        
        do {
            try await LocalizableMatcher(parameters: parameters).match()
            print("Success".green)
        } catch let error {
            if let localizedError = error as? LocalizerError {
                print(localizedError.description.red)
            } else {
                print(error.localizedDescription)
            }
            Localizer.exit()
        }
    }
}
