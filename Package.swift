// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "ZLStateView",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "ZLStateView",
            targets: ["ZLStateView"]
        )
    ],
    targets: [
        .target(
            name: "ZLStateView",
            path: "ZLStateView/Classes",
            publicHeadersPath: "."
        )
    ]
)

