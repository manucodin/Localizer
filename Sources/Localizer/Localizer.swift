import Darwin
import ArgumentParser
import Rainbow

@main
struct Localizer: AsyncParsableCommand {
    public static var configuration = CommandConfiguration(abstract: "Search and list all string in localizable.string")
    
    @Option(name: .shortAndLong, help: "Localize strings file path")
    private var localizableFilePath: String
    
    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "Paths to search strings localizables")
    private var searchPaths: [String]
    
    mutating func run() async throws {
        let parameters = Parameters(
            localizableFilePath: localizableFilePath,
            searchPaths: searchPaths
        )
        
        do {
            try await LocalizableMatcher(parameters: parameters).match()
            print("Success".green)
        } catch let error {
            if let localizedError = error as? LocalizerError {
                print(localizedError.description.red)
            } else {
                print(error.localizedDescription)
            }
            Localizer.exit(withError: error)
        }
    }
}
