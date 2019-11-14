// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Advent of Code",
    platforms: [.macOS(.v10_14)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(name: "advent", targets: ["advent"]),
        .library(name: "AOCCore", targets: ["AOCCore"]),
        .library(name: "AOC2019", targets: ["AOC2019"]),
        .library(name: "AOC2018", targets: ["AOC2018"]),
        .library(name: "AOC2017", targets: ["AOC2017"]),
        .library(name: "AOC2016", targets: ["AOC2016"]),
        .library(name: "AOC2015", targets: ["AOC2015"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "advent", dependencies: ["AOC2019"]),
        
        .target(name: "AOC2019", dependencies: ["AOCCore"]),
        .target(name: "AOC2018", dependencies: ["AOCCore"]),
        .target(name: "AOC2017", dependencies: ["AOCCore"]),
        .target(name: "AOC2016", dependencies: ["AOCCore"]),
        .target(name: "AOC2015", dependencies: ["AOCCore"]),
        
        .target(name: "AOCCore", dependencies: []),
        
        .testTarget(name: "AOCTests", dependencies: ["AOC2019", "AOC2018", "AOC2017", "AOC2016", "AOC2015"]),
    ]
)
