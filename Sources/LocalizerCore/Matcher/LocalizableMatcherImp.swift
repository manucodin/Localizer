//
//  LocalizableMatcherImp.swift
//  
//
//  Created by Manuel Rodriguez on 29/5/22.
//

import Foundation

public class LocalizableMatcherImp: LocalizableMatcher {
    private let localizablesDataSource: LocalizablesDataSource
    private let projectDataSource: ProjectDataSource
    
    init(withConfiguration configuration: Configuration) {
        self.localizablesDataSource = LocalizablesDataSourceImp(configuration: configuration)
        self.projectDataSource = ProjectDataSourceImp(configuration: configuration)
    }
    
    func matchLocalizables(parameters: Parameters) {
        let localizables = localizablesDataSource.fetchLocalizableKeys(fromFile: parameters.localizableFilePath)
        let projectLocalizables = projectDataSource.fetchLocalizables(fromPath: parameters.proyectPath)        
        debugPrint(projectLocalizables)
    }
}
