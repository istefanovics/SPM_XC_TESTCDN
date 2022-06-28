// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "spm_test",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "spm_test",
            targets: ["TestSDKTarget"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.

        //Binary target cant have dependency, we must use wrapper and target
        .binaryTarget(name: "spm_test",
                      url: "https://github.com/istefanovics/SPM_XC_TESTCDN/raw/main/xcframework/spm_test.xcframework2.zip",
                      checksum: "8cce4e76b251fbdc30bbe9f63c3edd8d87df016e428eed0fe00f78311fc84a81"),


        .target(
          name: "TestSDKTarget",
          dependencies: [.target(name: "TestSDKFrameworkWrapper",
                                 condition: .when(platforms: [.iOS]))],
          path: "Sources/TestTarget"
        ),

        .target(
            name: "TestSDKFrameworkWrapper",         // <--- new wrapper
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .target(name: "spm_test")    // <-- reference the actual binary target here
            ],
            path: "Sources/TestWrapper",
            publicHeadersPath: ""
        ),
    ],
    swiftLanguageVersions: [.v5]
)
