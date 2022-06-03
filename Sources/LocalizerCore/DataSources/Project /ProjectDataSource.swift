import Foundation

protocol ProjectDataSource {
    func fetchLocalizables(fromPath path: String) -> Set<String>
}
