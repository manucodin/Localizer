import Foundation
import Files

extension File {
    
    func isSupported(extensionsSupported: [ExtensionSupported]) -> Bool {
        guard let fileExtension = self.extension else { return false }
        
        return extensionsSupported.map{ $0.rawValue }.contains(fileExtension)
    }
}
