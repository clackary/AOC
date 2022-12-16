//
//  Day1.swift
//  test
//
//  Created by Dave DeLong on 12/23/17.
//  Copyright © 2015 Dave DeLong. All rights reserved.
//

struct Day1: Day {
    
    func part1() async throws -> String {
        var floor = 0
        for char in input().characters {
            if char == "(" { floor += 1 }
            if char == ")" { floor -= 1 }
        }
        return "\(floor)"
    }
    
    func part2() async throws -> String {
        var floor = 0
        for (position, char) in input().characters.indexed() {
            if char == "(" { floor += 1 }
            if char == ")" { floor -= 1 }
            if floor == -1 { return "\(position + 1)" }
        }
        fatalError("unreachable")
    }
    
}
