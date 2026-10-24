// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "StringSearchKit",
    platforms: [.macOS(.v12), .iOS(.v15), .tvOS(.v15)],
    products: [
        .library(name: "StringSearchKit", targets: ["StringSearchKit"])
    ],
    targets: [
        .target(name: "StringSearchKit"),
        .testTarget(
            name: "StringSearchKitTests",
            dependencies: ["StringSearchKit"],
            resources: [.copy("example-dictionary.txt")]
        )
    ]
)
