//
//  Day7.swift
//  AOC2022
//
//  Created by Dave DeLong on 12/16/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day7: Day {
    typealias Part1 = Int
    typealias Part2 = Int
    
    static var rawInput: String? { nil }

    func run() async throws -> (Part1, Part2) {
        let p1 = try await part1()
        let p2 = try await part2()
        return (p1, p2)
    }

    func part1() async throws -> Part1 {
        let rootDir = Entry.directory("/", nil)
        var fs = Filesystem(entries: [rootDir : []], cwd: rootDir)
        // Process file system
        for line in input().lines.raw {
            guard line != "" else { continue }
            let components = line.components(separatedBy: .whitespaces)

            if line.hasPrefix("$ cd") {
                if components.last == ".." {
                    guard let parent = fs.cwd.parent else { fatalError() }
                    fs.cwd = parent
                } else if components.last == "/" {
                    continue
                } else {
                    fs.cwd = .directory(components.last!, fs.cwd)
                    fs.entries[fs.cwd] = []
                }
            } else if line.hasPrefix("$ ls") {
                // Should do exactly nothing for ls
                continue
            } else if line.hasPrefix("dir") {
                // Add dir entry
                let name = components.last!
                fs.entries[fs.cwd]?.append(.directory(name, fs.cwd))
            } else {
                // Assume it's a file. Gather size and filename.
                guard fs.cwd.name != "/" else {
                    fs.entries[rootDir]!.append(.file(components.last!, Int(components.first!)!, nil))
                    continue
                }
                fs.entries[fs.cwd]?.append(.file(components.last!, Int(components.first!)!, fs.cwd))
            }
        }

        guard input().lines.raw.filter({$0.hasPrefix("dir ")}).count + 1 == fs.entries.count else {

            print(input().lines.raw.filter({$0.hasPrefix("dir ")}).count)
            print(Set(input().lines.raw.filter({$0.hasPrefix("dir ")})).count)
            return -1
        }

        func recursiveSum(_ a: [Entry]) -> Int {
            var result = 0

            for entry in a {
                switch entry.self {
                case .directory:
                    result += recursiveSum(fs.entries[entry]!)
                case .file:
                    result += entry.size
                }
            }

            return result
        }

        var result = 0

        for (_, entry) in fs.entries {
            let sum = recursiveSum(entry)
            if sum <= 100_000 {
                result += sum
            }
        }

        return result
    }

    func part2() async throws -> Part2 {
        let rootDir = Entry.directory("/", nil)
        var fs = Filesystem(entries: [rootDir : []], cwd: rootDir)
        // Process file system
        for line in input().lines.raw {
            guard line != "" else { continue }
            let components = line.components(separatedBy: .whitespaces)

            if line.hasPrefix("$ cd") {
                if components.last == ".." {
                    guard let parent = fs.cwd.parent else { fatalError() }
                    fs.cwd = parent
                } else if components.last == "/" {
                    continue
                } else {
                    fs.cwd = .directory(components.last!, fs.cwd)
                    fs.entries[fs.cwd] = []
                }
            } else if line.hasPrefix("$ ls") {
                // Should do exactly nothing for ls
                continue
            } else if line.hasPrefix("dir") {
                // Add dir entry
                let name = components.last!
                fs.entries[fs.cwd]?.append(.directory(name, fs.cwd))
            } else {
                // Assume it's a file. Gather size and filename.
                guard fs.cwd.name != "/" else {
                    fs.entries[rootDir]!.append(.file(components.last!, Int(components.first!)!, nil))
                    continue
                }
                fs.entries[fs.cwd]?.append(.file(components.last!, Int(components.first!)!, fs.cwd))
            }
        }

        guard input().lines.raw.filter({$0.hasPrefix("dir ")}).count + 1 == fs.entries.count else {

            print(input().lines.raw.filter({$0.hasPrefix("dir ")}).count)
            print(Set(input().lines.raw.filter({$0.hasPrefix("dir ")})).count)
            return -1
        }

        func recursiveSum(_ a: [Entry]) -> Int {
            var result = 0

            for entry in a {
                switch entry.self {
                case .directory:
                    result += recursiveSum(fs.entries[entry]!)
                case .file:
                    result += entry.size
                }
            }

            return result
        }

        let totalSpace = 70_000_000
        let requiredSpace = 30_000_000
        var acceptableDirectory: [Int] = []
        let rootSize = recursiveSum(fs.entries[rootDir]!)

        print("Space needed: \(requiredSpace - (totalSpace - rootSize))")

        for (dirName, entry) in fs.entries {
            let sum = recursiveSum(entry)
            if sum > (requiredSpace - (totalSpace - rootSize)) {
                print(dirName.name)
                acceptableDirectory.append(sum)
            }
        }

        return acceptableDirectory.min()!
    }

    indirect enum Entry: Hashable {
        case directory(String, Entry?)
        case file(String, Int, Entry?)

        var isDirectory: Bool {
            if case .directory = self { return true }
            return false
        }

        var name: String {
            switch self {
            case .directory(let n, _):
                return n
            case .file(let n, _, _):
                return n
            }
        }

        var size: Int {
            switch self {
            case .directory(_, _):
                return 0
            case .file(_, let s, _):
                return s
            }
        }

        var parent: Entry? {
            switch self {
            case .directory(_, let p):
                return p
            case .file(_, _, let p):
                return p
            }
        }
    }

    struct Filesystem {
        var entries: [Entry : [Entry]]
        var cwd: Entry
    }
}
