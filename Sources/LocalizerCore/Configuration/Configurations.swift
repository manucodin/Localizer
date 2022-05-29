//
//  Configurations.swift
//  
//
//  Created by Manuel Rodriguez on 28/5/22.
//

import Foundation

struct Configurations {
    static let `default`: Configuration = ConfigurationImp(
        localizableEncoding: .utf8,
        fileEncoding: .utf8,
        filesSupported: [.swift, .objC]
    )
}
