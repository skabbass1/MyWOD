// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyWOD",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.0.0"),
        .package(url: "https://github.com/Quick/Quick.git", from: "1.2.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.3"),
        .package(url: "https://github.com/IBM-Swift/Swift-SMTP.git", from: "1.1.3"),
        .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.1.0")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMajor(from: "1.7.1")),
        .package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/IBM-Swift/Health.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "MyWOD",
            dependencies: ["MyWODCore", "Kitura", "HeliumLogger"]),
        .target(
            name: "MyWODCore",
            dependencies: ["Alamofire", "SwiftSMTP", "Kitura", "CloudEnvironment", "Health"]),
        .testTarget(
            name: "MyWODTests",
        dependencies: ["MyWODCore","Quick", "Nimble"]
        )
    ]
)
