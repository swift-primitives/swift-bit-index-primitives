// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "swift-bit-index-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "Bit Index Primitives",
            targets: ["Bit Index Primitives"]
        ),
        .library(
            name: "Bit Index Primitives Test Support",
            targets: ["Bit Index Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(path: "../swift-bit-primitives"),
        .package(path: "../swift-index-primitives"),
        .package(path: "../swift-affine-primitives"),
        .package(path: "../swift-ordinal-primitives"),
    ],
    targets: [
        .target(
            name: "Bit Index Primitives",
            dependencies: [
                .product(name: "Bit Primitives", package: "swift-bit-primitives"),
                .product(name: "Index Primitives", package: "swift-index-primitives"),
                .product(name: "Affine Primitives", package: "swift-affine-primitives"),
                .product(name: "Ordinal Primitives", package: "swift-ordinal-primitives"),
            ]
        ),
        .target(
            name: "Bit Index Primitives Test Support",
            dependencies: [
                "Bit Index Primitives",
                .product(name: "Bit Primitives Test Support", package: "swift-bit-primitives"),
                .product(name: "Index Primitives Test Support", package: "swift-index-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Bit Index Primitives Tests",
            dependencies: [
                "Bit Index Primitives",
                "Bit Index Primitives Test Support",
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
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
