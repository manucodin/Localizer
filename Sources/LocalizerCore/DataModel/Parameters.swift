//
//  LocalizeOrder.swift
//  
//
//  Created by Manuel Rodriguez on 27/5/22.
//

import Foundation

struct Parameters {
    let localizableFilePath: String
    let proyectPath: String
    let reverseLocalizable: Bool
    
    init(localizableFilePath: String, proyectPath: String, reverseLocalizable: Bool) {
        self.localizableFilePath = localizableFilePath
        self.proyectPath = proyectPath
        self.reverseLocalizable = reverseLocalizable
    }
}
