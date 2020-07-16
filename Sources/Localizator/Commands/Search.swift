//
//  Search.swift
//  
//
//  Created by Manuel Rodríguez Sebastián on 30/06/2020.
//

import ArgumentParser
import Foundation
import Rainbow

struct Search :ParsableCommand{
    
    public static var configuration = CommandConfiguration(abstract: "Search and list all string in localizable.string")
    
    @Option(name: .shortAndLong, help: "Localize string file path")
    private var localizablePath :String = "./en.lproj/Localizable.strings"
    
    @Option(name: .shortAndLong, help: "Proyect path")
    private var proyectPath :String = "."
    
    @Flag(name: .short, help: "Compare your localizable keys against your coding keys, if you want compare your coding keys against your localizable, send -c")
    private var compareLocalizable :Bool = true
    
    @Flag(name: .long, help: "Show localized path")
    private var showPath :Bool = false
    
    func run() throws {
        let fileManager = FileManager()
        
        let localizableKeys = try fileManager.localizableKeys(inPath: localizablePath)
       
        let proyectKeys = try fileManager.searchLocalizableKeys(inDirectoryPath: proyectPath)
               
        var results = [LocalizableKey]()

        if(compareLocalizable == false){
            results = fileManager.compareKeys(mainKeys: localizableKeys, secondaryKeys: proyectKeys)
        }else{
            results = fileManager.compareKeys(mainKeys: proyectKeys, secondaryKeys: localizableKeys)
        }

        let unusedResults = results.filter{$0.inUse == false}
        unusedResults.forEach{
            print("KEY -> \($0.key)\(showPath == true ? " PATH: \($0.path)" : "")")
        }
        
        if(unusedResults.isEmpty){
            print("SUCCESS".green)
        }else{
            print("UNUSED KEYS: \(unusedResults.count)".red)
        }
    }
}
