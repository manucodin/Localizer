//
//  Localize.swift
//  
//
//  Created by Manuel Rodríguez Sebastián on 30/06/2020.
//

import ArgumentParser

struct Localize :ParsableCommand{
    
    public static var configuration = CommandConfiguration(abstract: "Download or update your Localizable.strings file")
    
    func run() throws {
        print("Traducir proyecto")
    }
}
