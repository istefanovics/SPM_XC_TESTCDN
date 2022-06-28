// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "spm_test",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        //.library(
        //    name: "spm_test",
        //    targets: ["spm_test"])

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

        //.target(
        //    name: "spm_test",
        //    dependencies: [
        //        .product(name: "Alamofire", package: "Alamofire")
        //    ],
        //    path: "spm_test"
        //)

        //.binaryTarget(name: "spm_test",
        //              url: "https://github.com/istefanovics/spm_test/raw/master/xcframework/spm_test.xcframework2.zip",
        //              checksum: "f73f4c170617683386f85d017732d4653a99bbce14e88ce91bedb72fc2270151"),

        .binaryTarget(name: "spm_test",
                      url: "https://github.com/istefanovics/SPM_XC_TESTCDN/raw/master/xcframework/spm_test.xcframework3.zip",
                      checksum: "bc651becb37857a28c7d928df933b0d1c4f8a87dc6c88cb4f88a0fa2a8e8889a"),


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
