// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GaberExtensions",
    platforms: [
        .macOS(.v10_15), .iOS(.v17), .tvOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GaberExtensions",
            targets: ["GaberExtensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-case-paths", from: "0.9.1"),
        .package(url: "https://github.com/siteline/SwiftUI-Introspect", from: "0.1.4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GaberExtensions",
            dependencies: [
                .product(name: "CasePaths", package: "swift-case-paths"),
                .product(name: "Introspect", package: "SwiftUI-Introspect"),
            ]),
        .testTarget(
            name: "GaberExtensionsTests",
            dependencies: [
                "GaberExtensions",
            ]),
    ]
)
