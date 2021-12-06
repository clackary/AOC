//
//  Day6.swift
//  test
//
//  Created by Dave DeLong on 11/25/21.
//  Copyright © 2021 Dave DeLong. All rights reserved.
//

import AOCCore

class Day6: Day {

    override func run() -> (String, String) {
        return super.run()
    }

    override func part1() -> String {
        return "\(countFish(80))"
    }

    override func part2() -> String {
        return "\(countFish(256))"
    }
    
    func countFish(_ days: Int) -> Int {
        var fish = CountedSet(input.integers)
        
        for _ in 0 ..< days {
            var newFish = CountedSet<Int>()
            for (day, count) in fish {
                var daysLeft = day-1
                if daysLeft < 0 {
                    daysLeft = 6
                    newFish[8, default: 0] += count
                }
                newFish[daysLeft, default: 0] += count
            }
            fish = newFish
        }
        
        return fish.values.sum
    }

}
