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
    private var localizableFilePath: String = "./en.lproj/Localizable.strings"
    
    @Option(name: .shortAndLong, help: "Proyect path")
    private var proyectPath: String = "."
    
    @Flag(name: .long, help: "Compare your coding keys against your localizable")
    private var reverseLocalizable: Bool = false
    
    public func run() throws {
        let parameters = Parameters(
            localizableFilePath: localizableFilePath,
            proyectPath: proyectPath,
            reverseLocalizable: reverseLocalizable
        )
        
        let localizableMatcher = LocalizableMatcherImp(withConfiguration: Configurations.default)
        localizableMatcher.matchLocalizables(parameters: parameters)
    }
    
    public init() {}
}
