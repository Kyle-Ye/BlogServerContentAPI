// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "BlogServerContentAPI",
    platforms: [
       .macOS(.v12),
    ],
    products: [
        .library(name: "ContentAPI", targets: ["ContentAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.30.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
    ],
    targets: [
        .target(name: "ContentAPI", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "Fluent", package: "fluent"),
        ]),
        .testTarget(name: "ContentAPITests", dependencies: ["ContentAPI"]),
    ]
)
