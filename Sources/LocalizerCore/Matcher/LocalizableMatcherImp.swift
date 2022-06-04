import Foundation
import Progress
import Rainbow

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
        let unusedKeys = searchUnusedKeys(
            mandatoryLocalizables: parameters.reverseLocalizable ? projectLocalizables : localizables,
            secondaryLocalizables: parameters.reverseLocalizable ? localizables : projectLocalizables
        )
        
        if parameters.showUnusedKeys {
            unusedKeys.forEach{ print($0) }
        }
        
        if unusedKeys.isEmpty {
            print("Successfull! Has 0 unused localizables strings".green)
        } else {
            print("Fetched \(unusedKeys.count) unused localizables strings".red)
        }
    }
    
    private func searchUnusedKeys(mandatoryLocalizables: Set<String>, secondaryLocalizables: Set<String>) -> Set<String>{
        var unusedLocalizables = Set<String>()
        
        mandatoryLocalizables.forEach{ mandatoryLocalizable in
            if !secondaryLocalizables.contains(mandatoryLocalizable) {
                unusedLocalizables.insert(mandatoryLocalizable)
            }
        }
        
        return unusedLocalizables
    }
}
