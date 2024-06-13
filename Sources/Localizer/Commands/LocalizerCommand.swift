//
//  LocalizerCommand.swift
//
//
//  Created by Manuel Rodriguez Sebastian on 13/6/24.
//

import Foundation

protocol LocalizerCommand {
    associatedtype Parameters
    
    func buildParameters() -> Parameters
    func handleError(_ error: any Error)
}

extension LocalizerCommand {
    func handleError(_ error: any Error) {
        if let localizedError = error as? LocalizerError {
            print(localizedError.description.red)
        } else {
            print(error.localizedDescription)
        }
        Localizer.exit()
    }
}
