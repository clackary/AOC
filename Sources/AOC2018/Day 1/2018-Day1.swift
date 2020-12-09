//
//  Day1.swift
//  test
//
//  Created by Dave DeLong on 12/23/17.
//  Copyright © 2017 Dave DeLong. All rights reserved.
//

class Day1: Day {
    
    override func part1() -> String {
        let sum = input.lines.integers.sum
        return "\(sum)"
    }
    
    override func part2() -> String {
        let integers = input.lines.integers
        
        var frequency = 0
        var seen = Set([frequency])
        for f in integers.cycled() {
            frequency += f
            if seen.insert(frequency).inserted == false { return "\(frequency)" }
        }
        fatalError("unreachable")
    }
    
}
