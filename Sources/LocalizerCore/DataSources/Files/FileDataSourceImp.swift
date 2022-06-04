import Foundation
import Files

class FileDataSourceImp {}

extension FileDataSourceImp: FileDataSource {    
    func fetchFileContent(fromPath filePath: String, encoding: String.Encoding) -> String? {
        guard let file = try? File(path: filePath) else { return nil }
        guard let fileContent = try? file.readAsString(encodedAs: encoding) else { return nil }
        
        return fileContent
    }
}
