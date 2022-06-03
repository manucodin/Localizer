import Foundation

protocol RegexMatcher {
    func fetchLocalizableKeys(fromFile filePath: String) -> Set<String>
}
