import Foundation

struct Configurations {
    static let `default`: Configuration = ConfigurationImp(
        localizableEncoding: .utf8,
        fileEncoding: .utf8,
        filesSupported: [.swift, .objC],
        fileRegexExpressions: [
            #"(?!NSLocalizedString\(@\")(?:\w+)(?=\")|(?!\")(\w+)(?=\"\.localized\(\))"#
        ]
    )
}
