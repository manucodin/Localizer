//
//  Search.swift
//  
//
//  Created by Manuel Rodríguez Sebastián on 30/06/2020.
//

import ArgumentParser
import Foundation

public struct Localizer: ParsableCommand {
    
    public static var configuration = CommandConfiguration(abstract: "Search and list all string in localizable.string")
    
    @Option(name: .shortAndLong, help: "Localize strings file path")
    private var localizableFilePath: String
    
    @Option(name: .shortAndLong, help: "Proyect path")
    private var proyectPath: String
    
    @Flag(name: .shortAndLong, help: "Compare your coding keys against your localizable")
    private var reverseLocalizable: Bool = false
    
    @Flag(name: .shortAndLong, help: "Show unused localizable keys")
    private var showUnusedKeys: Bool = false
    
    public func run() throws {
        let parameters = Parameters(
            localizableFilePath: localizableFilePath,
            proyectPath: proyectPath,
            reverseLocalizable: reverseLocalizable,
            showUnusedKeys: showUnusedKeys
        )
        
        let localizableMatcher = LocalizableMatcherImp(withConfiguration: Configurations.default)
        localizableMatcher.matchLocalizables(parameters: parameters)
    }
    
    public init() {}
}
