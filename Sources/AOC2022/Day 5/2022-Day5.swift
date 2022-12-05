//
//  Day5.swift
//  AOC2022
//
//  Created by Dave DeLong on 10/12/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day5: Day {
    typealias Part1 = String
    typealias Part2 = String
    
    lazy var startingState: Array<[Character]> = {
        let crateLines = input().lines.raw.split(on: \.isEmpty).first!
        
        // make sure the lines are all the same length
        let longestLine = crateLines.max(of: \.count)
        let padded = crateLines.map { $0.padding(toLength: longestLine, with: " ")}
        
        return stride(from: 1, to: longestLine, by: 4).map { offset in
            padded.map { $0[offset: offset] }.filter(\.isLetter)
        }
    }()
    
    lazy var instructions: Array<(Int, Int, Int)> = {
        let r = Regex(#"move (\d+) from (\d+) to (\d+)"#)
        return input().lines.raw.compactMap { l in
            guard let m = r.firstMatch(in: l) else { return nil }
            // subtract one because the instructions are 1-indexed, but arrays are 0-indexed
            return (m[int: 1]!, m[int: 2]! - 1, m[int: 3]! - 1)
        }
    }()

    func part1() async throws -> Part1 {
        
        var stacks = startingState
        for (number, source, dest) in instructions {
            let stack = stacks[source]
            
            let removed = stack[0 ..< number]
            
            stacks[source] = Array(stack.dropFirst(number))
            stacks[dest] = removed.reversed() + stacks[dest]
        }
        
        let tops = stacks.map { $0.first! }
        
        return String(tops)
    }

    func part2() async throws -> Part2 {
        
        var stacks = startingState
        for (number, source, dest) in instructions {
            let stack = stacks[source]
            
            let removed = stack[0 ..< number]
            
            stacks[source] = Array(stack.dropFirst(number))
            stacks[dest] = removed + stacks[dest]
        }
        
        let tops = stacks.map { $0.first! }
        
        return String(tops)
    }

}
