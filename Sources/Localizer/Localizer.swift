import Darwin
import ArgumentParser
import Rainbow

@main
struct Localizer: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "🔍 Search unlocalized strings on your project easily and quickly",
        version: "1.2.0",
        subcommands: [
            Compare.self,
            Search.self
        ],
        defaultSubcommand: Compare.self
    )
}
