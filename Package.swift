// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "openusd",
    platforms: [.macOS(.v14), .iOS(.v17)],
    products: [
        .library(
            name: "SwiftPyUSD",
            targets: ["SwiftPyUSD"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/felfoldy/SwiftPy", from: "0.14.0"),
        .package(url: "https://github.com/apple/SwiftUsd", from: "5.1.0"),
    ],
    targets: [
        .target(
            name: "SwiftPyUSD",
            dependencies: [
                .product(name: "OpenUSD", package: "SwiftUsd"),
                "SwiftPy",
            ],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx)
            ]
        ),
        
        .testTarget(
            name: "SwiftPyUSDTests",
            dependencies: ["SwiftPyUSD"],
            swiftSettings: [
                .interoperabilityMode(.Cxx)
            ]
        )
    ],
    cxxLanguageStandard: .gnucxx17
)
