// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfSwift",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "aoswift", targets: ["AdventOfSwift"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .executableTarget(
            name: "AdventOfSwift",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        )
    ]
)
