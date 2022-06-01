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
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.2.0"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "10.0.0"),
        .package(url: "https://github.com/sharplet/Regex.git", from: "2.1.0")
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
            .product(name: "Regex", package: "Regex")
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
