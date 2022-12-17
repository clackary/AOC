//
//  Day3.swift
//  AOC2022
//
//  Created by Dave DeLong on 12/16/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day3: Day {
    typealias Part1 = Int
    typealias Part2 = Int
    
    static var rawInput: String? { nil }

    struct Rucksack {
        let contents: String
        var compartments: [Substring] {
            get {
                return [self.contents.prefix(self.contents.count / 2), self.contents.suffix(self.contents.count / 2)]
            }
        }
    }

    func run() async throws -> (Part1, Part2) {
        let p1 = try await part1()
        let p2 = try await part2()
        return (p1, p2)
    }

    func part1() async throws -> Part1 {
        let array = input().lines.raw
        var rucksacks: [Rucksack] = []
        for str in array {
            rucksacks.append(Rucksack(contents: str))
        }

        var result = 0

        for sack in rucksacks {
            let common = Set<Character>(sack.compartments[0]).intersection(sack.compartments[1])
            if common.isEmpty {
                continue
            }
            if common.first!.isUppercase {
                result += Int(common.first!.asciiValue! - UInt8(38))
            } else {
                result += Int(common.first!.asciiValue! - UInt8(96))
            }
            print("char: \(common.first!)\nvalue: \(common.first!.asciiValue!)")
        }
        return result
    }

    func part2() async throws -> Part2 {
        let array = input().lines.raw
        var rucksacks: [Rucksack] = []
        for str in array {
            rucksacks.append(Rucksack(contents: str))
        }

        var result = 0

        var rucksackGroups: [[Rucksack]] = []

        for i in stride(from: 0, to: rucksacks.count - 1, by: 3) {
            rucksackGroups.append([rucksacks[i], rucksacks[i+1], rucksacks[i+2]])
        }

        for group in rucksackGroups {
            let common = Set<Character>(group[0].contents).intersection(group[1].contents).intersection(group[2].contents)
            if common.isEmpty {
                continue
            }
            if common.first!.isUppercase {
                result += Int(common.first!.asciiValue! - UInt8(38))
            } else {
                result += Int(common.first!.asciiValue! - UInt8(96))
            }
        }

        return result
    }
}
