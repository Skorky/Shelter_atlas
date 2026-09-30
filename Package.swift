// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "UkrytyCore",
    platforms: [.macOS(.v13), .iOS(.v17)],
    products: [.library(name: "UkrytyCore", targets: ["UkrytyCore"])],
    targets: [
        .target(name: "UkrytyCore", path: "Ukryty/Core"),
        .testTarget(name: "UkrytyCoreTests", dependencies: ["UkrytyCore"], path: "Tests")
    ]
)
