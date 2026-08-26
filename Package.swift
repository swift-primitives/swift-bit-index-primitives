// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-bit-index",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Bit Index",
            targets: ["Bit Index"]
        ),
        .library(
            name: "Bit Index Test Support",
            targets: ["Bit Index Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-bit.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-affine.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-byte.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Bit Index",
            dependencies: [
                .product(name: "Bit", package: "swift-bit"),
                .product(name: "Index", package: "swift-index"),
                .product(name: "Affine", package: "swift-affine"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
        .target(
            name: "Bit Index Test Support",
            dependencies: [
                "Bit Index",
                .product(name: "Bit Test Support", package: "swift-bit"),
                .product(name: "Index Test Support", package: "swift-index"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Bit Index Tests",
            dependencies: [
                "Bit Index",
                "Bit Index Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
