import ArgumentParser

struct Localizator :ParsableCommand{
    static let configuration = CommandConfiguration(
        abstract: "Localize and search keys in proyect",
        version: "0.0.1",
        subcommands: [
            Search.self
        ]
    )
    
    init() {}
}

Localizator.main()
