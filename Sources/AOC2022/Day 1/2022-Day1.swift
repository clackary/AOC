//
//  Day1.swift
//  AOC2022
//
//  Created by Dave DeLong on 12/16/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day1: Day {
    typealias Part1 = Int
    typealias Part2 = Int

    var results: [Int] = []

    func run() async throws -> (Part1, Part2) {
        var sum = 0

        for line in input().lines.raw {
            if line == "" {
                results.append(sum)
                sum = 0
                continue
            }
            sum += Int(line)!
        }

        let p1 = try await part1()
        let p2 = try await part2()
        return (p1, p2)
    }

    func part1() async throws -> Part1 {
        return Int(results.max()!)
    }

    func part2() async throws -> Part2 {
        let sorted = results.sorted(by: >)
        return sorted[0] + sorted[1] + sorted[2]
    }
}
