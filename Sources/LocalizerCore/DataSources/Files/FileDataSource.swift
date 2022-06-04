import Foundation

protocol FileDataSource {
    func fetchFileContent(fromPath filePath: String, encoding: String.Encoding) -> String?
}
