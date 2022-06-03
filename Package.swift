// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Localizer",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "localizer", targets: ["Localizer"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "0.2.0")),
        .package(url: "https://github.com/JohnSundell/Files", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/onevcat/Rainbow", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "10.0.0")),
        .package(url: "https://github.com/jkandzi/Progress.swift.git", .upToNextMajor(from: "0.4.0"))
    ],
    targets: [
        .target(
            name: "Localizer",
            dependencies: ["LocalizerCore"]
        ),
        .target(name: "LocalizerCore", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            .product(name: "Files", package: "Files"),
            .product(name: "Rainbow", package: "Rainbow"),
            .product(name: "Progress", package: "Progress.swift")
        ]),
        .testTarget(
            name: "LocalizerTests",
            dependencies: ["Localizer", "Nimble"],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
