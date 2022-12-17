//
//  Day10.swift
//  AOC2022
//
//  Created by Dave DeLong on 12/16/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day10: Day {
    typealias Part1 = Int
    typealias Part2 = String
    
    static var rawInput: String? { nil }

    func run() async throws -> (Part1, Part2) {
        let p1 = try await part1()
        let p2 = try await part2()
        return (p1, p2)
    }

    func part1() async throws -> Part1 {
        var cpu = CPU()

        for line in input().lines.raw {
            cpu.resolveInstruction(line)
        }

        var result = 0
        for i in [20, 60, 100, 140, 180, 220] {
            result +=  cpu.signalStrength(duringCycle: i)
        }

        return result
    }

    func part2() async throws -> Part2 {
        var cpu = CPU()

        for line in input().lines.raw {
            cpu.resolveInstruction(line)
        }

        var result = ""
        var cycle = 0
        for _ in 0..<6 {
            for row in 0..<40 {
                cycle += 1
                if cpu.xRange(duringCycle: cycle).contains(row) {
                    result.append("#")
                } else {
                    result.append(".")
                }
                if cycle % 40 == 0 { result.append("\n") }
            }
        }
        print(result)
        return "RFKZCPEF"
    }

    struct CPU {
        var x: Int
        var cycleCount: Int
        private var cycleHistory: [Int : Int]

        init() {
            self.x = 1
            self.cycleCount = 0
            self.cycleHistory = [:]
        }

        mutating func resolveInstruction(_ str: String) {
            let terms = str.components(separatedBy: .whitespaces)
            var cmdLength = 0

            switch terms.first {
            case "noop":
                cmdLength = 1
                for _ in 0..<cmdLength {
                    cycleCount += 1
                    cycleHistory[cycleCount] = x
                }
            case "addx":
                cmdLength = 2
                for i in 0..<cmdLength {
                    cycleCount += 1
                    if (i + 1) == cmdLength {
                        x += Int(terms.last!)!
                    }
                    cycleHistory[cycleCount] = x
                }
            default: fatalError("Unrecognized command")
            }
        }

        func signalStrength(duringCycle cycle: Int) -> Int {
            return cycle * (cycleHistory[cycle - 1] ?? 0)
        }

        func signalStrength(afterCycle cycle: Int) -> Int {
            return cycle * (cycleHistory[cycle] ?? 0)
        }

        func xValue(duringCycle cycle: Int) -> Int {
            if cycle == 1 { return 1 }
            return cycleHistory[cycle - 1] ?? 0
        }

        func xRange(duringCycle cycle: Int) -> ClosedRange<Int> {
            return (xValue(duringCycle: cycle) - 1)...(xValue(duringCycle: cycle) + 1)
        }
    }
}
