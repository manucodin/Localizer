import Foundation

protocol LocalizablesDataSource {
    func fetchLocalizableKeys(fromFile filePath :String) -> Set<String>
}
