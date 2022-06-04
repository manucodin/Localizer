import Foundation

struct Parameters {
    let localizableFilePath: String
    let proyectPath: String
    let reverseLocalizable: Bool
    let showUnusedKeys: Bool
    
    init(localizableFilePath: String, proyectPath: String, reverseLocalizable: Bool, showUnusedKeys: Bool) {
        self.localizableFilePath = localizableFilePath
        self.proyectPath = proyectPath
        self.reverseLocalizable = reverseLocalizable
        self.showUnusedKeys = showUnusedKeys
    }
}
