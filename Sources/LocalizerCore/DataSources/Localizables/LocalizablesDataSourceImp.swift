import Foundation

class LocalizablesDataSourceImp: LocalizablesDataSource {    
    private let configuration: Configuration
    private let fileDataSource: FileDataSource
    
    init(fileDataSource: FileDataSource = FileDataSourceImp(), configuration: Configuration) {
        self.configuration = configuration
        self.fileDataSource = fileDataSource
    }
    
    func fetchLocalizableKeys(fromFile filePath :String) -> Set<String> {
        guard let fileContent = fetchFileContent(fromFile: filePath) else { return [] }
        
        print("Fetching localizables from: \(filePath)")
        
        return searchLocalizableKeys(fileContent: fileContent)
    }
    
    private func fetchFileContent(fromFile filePath: String) -> String? {
        guard let fileContent = fileDataSource.fetchFileContent(fromPath: filePath, encoding: configuration.localizableEncoding) else { return nil }
        
        return fileContent
    }
    
    private func searchLocalizableKeys(fileContent: String) -> Set<String> {
        let localizables = fileContent.components(separatedBy: .newlines).filter{ isNewTextLine(text: $0) }
        let keyValue = localizables.compactMap{ getKeyValue(fromLocalizable:$0) }
        let setValues = Set<String>(keyValue)
        
        print("Fetched \(setValues.count) localizables")
        
        return setValues
    }
    
    private func isNewTextLine(text: String) -> Bool {
        guard let lastChracter = text.last else { return false }
        guard lastChracter == ";" else { return false}
        
        return true
    }
    
    private func getKeyValue(fromLocalizable localizable: String) -> String? {
        return localizable.split(separator: "=").first?.clean()
    }
}
