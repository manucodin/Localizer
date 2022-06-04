import Foundation
import Files
import Progress

class ProjectDataSourceImp: ProjectDataSource {
    private let configuration: Configuration
    private let regexMatcher: RegexMatcher
    
    init(configuration: Configuration) {
        self.configuration = configuration
        self.regexMatcher = RegexMatcherImp(configuration: configuration)
    }
    
    func fetchLocalizables(fromPath path: String) -> Set<String> {
        let localizableKeys = fetchLocalizableKeys(fromPath: path)
        return localizableKeys
    }
    
    private func fetchLocalizableKeys(fromPath path: String) -> Set<String> {
        print("Searching localizable keys from \(path)")
        
        let files = fetchFiles(fromPath: path)
        var localizableKeys = Set<String>()
        
        for file in Progress(files) {
            let fileLocalizables = regexMatcher.fetchLocalizableKeys(fromFile: file.path)
            localizableKeys.formUnion(fileLocalizables)
        }
        
        return localizableKeys
    }
    
    private func fetchFiles(fromPath path: String) -> [File] {
        guard let folder = fetchFolder(fromPath: path) else { return [] }
        
        let subFolders = folder.subfolders.recursive
        let files = subFolders.flatMap{ $0.files.filter{ $0.isSupported(extensionsSupported: configuration.filesSupported) } }
            
        return files
    }
    
    private func fetchFolder(fromPath path: String) -> Folder? {
        guard let folder = try? Folder(path: path) else { return nil }
        
        return folder
    }
}
