//
//  Localize.swift
//  
//
//  Created by Manuel Rodríguez Sebastián on 30/06/2020.
//

import ArgumentParser

struct Localize :ParsableCommand{
    public static var configuration = CommandConfiguration(abstract: "Localize proyect strings")
    
    func run() throws {
        print("Traducir proyecto")
    }
}
