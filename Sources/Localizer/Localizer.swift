import Darwin
import ArgumentParser
import Rainbow

@main
struct Localizer: AsyncParsableCommand {
    public static var configuration = CommandConfiguration(
        abstract: "🔍 Search unlocalized strings on your project easily and quickly",
        version: "1.0.0",
        subcommands: [
            Compare.self
        ],
        defaultSubcommand: Compare.self
    )
}
