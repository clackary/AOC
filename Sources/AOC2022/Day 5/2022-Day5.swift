//
//  Day5.swift
//  AOC2022
//
//  Created by Dave DeLong on 12/16/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day5: Day {
    typealias Part1 = String
    typealias Part2 = String
    
    static var rawInput: String? { nil }

    func run() async throws -> (Part1, Part2) {
        let p1 = try await part1()
        let p2 = try await part2()
        return (p1, p2)
    }

    func part1() async throws -> Part1 {
        var stacks: [[String]] = [
            ["F", "D", "B", "Z", "T", "J", "R", "N", ],
            ["R", "S", "N", "J", "H", ],
            ["C", "R", "N", "J", "G", "Z", "F", "Q", ],
            ["F", "V", "N", "G", "R", "T", "Q", ],
            ["L", "T", "Q", "F", ],
            ["Q", "C", "W", "Z", "B", "R", "G", "N", ],
            ["F", "C", "L", "S", "N", "H", "M", ],
            ["D", "N", "Q", "M", "T", "J", ],
            ["P", "G", "S", ],
        ]
        let strings = input().lines.raw
        var array: [StackInstruction] = []

        for str in strings {
            guard str.starts(with: "move") else { continue }
            let comps = str.components(separatedBy: .whitespaces)
            guard comps.count == 6 else { return "" }

            array.append(StackInstruction(amount: Int(comps[1])!, source: Int(comps[3])! - 1, destination: Int(comps[5])! - 1))
        }

        var result = ""

        for instruction in array {
            var newStack: [String] = stacks[instruction.destination]
            var tempStack: [String] = []
            for _ in 0..<instruction.amount {
                tempStack.append(stacks[instruction.source].removeLast())
            }

            newStack += tempStack

            // Part one
            stacks[instruction.destination] = newStack
        }

        for stack in stacks {
            result.append(stack.last!)
        }

        return result
    }

    func part2() async throws -> Part2 {
        var stacks: [[String]] = [
            ["F", "D", "B", "Z", "T", "J", "R", "N", ],
            ["R", "S", "N", "J", "H", ],
            ["C", "R", "N", "J", "G", "Z", "F", "Q", ],
            ["F", "V", "N", "G", "R", "T", "Q", ],
            ["L", "T", "Q", "F", ],
            ["Q", "C", "W", "Z", "B", "R", "G", "N", ],
            ["F", "C", "L", "S", "N", "H", "M", ],
            ["D", "N", "Q", "M", "T", "J", ],
            ["P", "G", "S", ],
        ]
        let strings = input().lines.raw
        var array: [StackInstruction] = []

        for str in strings {
            guard str.starts(with: "move") else { continue }
            let comps = str.components(separatedBy: .whitespaces)
            guard comps.count == 6 else { return "" }

            array.append(StackInstruction(amount: Int(comps[1])!, source: Int(comps[3])! - 1, destination: Int(comps[5])! - 1))
        }

        var result = ""

        for instruction in array {
            var newStack: [String] = stacks[instruction.destination]
            var tempStack: [String] = []
            for _ in 0..<instruction.amount {
                tempStack.append(stacks[instruction.source].removeLast())
            }

            newStack += tempStack.reversed()

            // Part one
            stacks[instruction.destination] = newStack
        }

        for stack in stacks {
            result.append(stack.last!)
        }

        return result
    }

    struct StackInstruction {
        let amount: Int
        let source: Int
        let destination: Int
    }
}
