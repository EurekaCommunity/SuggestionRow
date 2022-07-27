// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "SuggestionRow",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "SuggestionRow", targets: ["SuggestionRow"])
    ],
    dependencies: [
        .package(url: "https://github.com/xmartlabs/Eureka.git", from: "5.3.6"),
    ],
    targets: [
        .target(
            name: "SuggestionRow",
            dependencies: ["Eureka"],
            path: "Sources"
        ),
        .testTarget(
            name: "SuggestionRowTests",
            dependencies: ["SuggestionRow"],
            path: "SuggestionRowTests"
        )
    ]
)
