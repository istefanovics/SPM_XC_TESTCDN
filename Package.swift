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
            targets: ["spm_test"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.7.0")),
        .package(url: "https://github.com/jankaltoun/AlamofireEasyLogger.git", .upToNextMajor(from: "1.6.0")),
        .package(url: "https://github.com/airbnb/lottie-ios.git", .upToNextMajor(from: "3.2.0")),
        // From API
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Flight-School/AnyCodable.git", .upToNextMajor(from: "0.6.1")),
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.

        //Binary target cant have dependency, we must use wrapper and target
        .binaryTarget(name: "spm_test",
                      url: "https://github.com/istefanovics/SPM_XC_TESTCDN/raw/main/xcframework/spm_test.xcframework9.zip",
                      checksum: "6acb802f0a2341434adf93a46e64d01756e4eab4a51d41c1629fc61ce7b4cf6d"),


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
                .product(name: "AnyCodable", package: "AnyCodable"),
                .product(name: "AlamofireEasyLogger", package: "AlamofireEasyLogger"),
                .product(name: "Lottie", package: "lottie-ios"),
                .product(name: "Swinject", package: "Swinject"),
                .product(name: "RxSwift", package: "RxSwift"),
                .target(name: "spm_test")    // <-- reference the actual binary target here
            ],
            path: "Sources/TestWrapper",
            publicHeadersPath: ""
        ),
    ],
    swiftLanguageVersions: [.v5]
)
