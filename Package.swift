// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Localizer",
    platforms: [.macOS(.v10_15)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/JohnSundell/Files", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/onevcat/Rainbow", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "Localizer",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Files", package: "Files"),
                .product(name: "Rainbow", package: "Rainbow")
            ]),
        .testTarget(
            name: "LocalizerTests",
            dependencies: ["Localizer"]),
    ]
)
