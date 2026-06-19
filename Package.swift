// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "comet",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.97.0")
    ],
    targets: [
        .systemLibrary(name: "CZlib", path: "czlib"),
        .executableTarget(
            name: "comet",
            dependencies: [
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .target(name: "CZlib", condition: .when(platforms: [.linux])),
            ],
            path: "src"
        ),
        .testTarget(
            name: "tests",
            dependencies: [
                "comet",
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
            ],
            path: "tests"
        )
    ]
)
