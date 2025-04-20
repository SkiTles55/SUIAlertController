// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SUIAlertController",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "SUIAlertController",
            targets: ["SUIAlertController"]),
    ],
    targets: [
        .target(
            name: "SUIAlertController"),
        .testTarget(
            name: "SUIAlertControllerTests",
            dependencies: ["SUIAlertController"]
        ),
    ]
)
