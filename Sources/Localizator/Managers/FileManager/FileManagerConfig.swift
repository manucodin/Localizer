//
//  File.swift
//  
//
//  Created by Manuel Rodríguez Sebastián on 02/07/2020.
//

import Foundation

enum ExtensionSupported :String{
    case swift = "swift"
    case objectiveC = "m"
}

struct FileManagerConfig{
    var extensions :[ExtensionSupported] = [
        .swift,
        .objectiveC
    ]    
 }
