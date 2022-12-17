//
//  Day4.swift
//  AOC2022
//
//  Created by Dave DeLong on 12/16/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day4: Day {
    typealias Part1 = Int
    typealias Part2 = Int
    
    static var rawInput: String? { nil }

    func run() async throws -> (Part1, Part2) {
        let p1 = try await part1()
        let p2 = try await part2()
        return (p1, p2)
    }

    func part1() async throws -> Part1 {
        var pairs: [Pair] = []
        for str in input().lines.raw {
            let places = str.components(separatedBy: CharacterSet(charactersIn: ",-")).map { Int($0)! }
            guard places.count == 4 else {
                fatalError()
            }
            pairs.append(Pair(firstAssignment: places[0]...places[1], secondAssignment: places[2]...places[3]))
        }

        var result = 0

        for pair in pairs {
            // Part one - does one fully contain the other
            if pair.fullyContains() {
                result += 1
            }
        }

        return result
    }

    func part2() async throws -> Part2 {
        var pairs: [Pair] = []
        for str in input().lines.raw {
            let places = str.components(separatedBy: CharacterSet(charactersIn: ",-")).map { Int($0)! }
            guard places.count == 4 else {
                fatalError()
            }
            pairs.append(Pair(firstAssignment: places[0]...places[1], secondAssignment: places[2]...places[3]))
        }

        var result = 0

        for pair in pairs {
            if pair.firstAssignment.overlaps(pair.secondAssignment) {
                result += 1
            }
        }

        return result
    }
    
    struct Pair {
        let firstAssignment: ClosedRange<Int>
        let secondAssignment: ClosedRange<Int>

        func fullyContains() -> Bool {
            if firstAssignment.contains(secondAssignment) {
                return true
            }
            if secondAssignment.contains(firstAssignment) {
                return true
            }
            return false
        }
    }
}
