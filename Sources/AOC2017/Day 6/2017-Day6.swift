//
//  Day6.swift
//  test
//
//  Created by Dave DeLong on 12/22/17.
//  Copyright © 2017 Dave DeLong. All rights reserved.
//

extension Year2017 {

public class Day6: Day {
    
    struct Seen: Hashable {
        static func ==(lhs: Seen, rhs: Seen) -> Bool { return lhs.array == rhs.array }
        let array: Array<Int>
        func hash(into hasher: inout Hasher) { hasher.combine(array) }
        init(_ array: Array<Int>) {
            self.array = array
        }
        func redistribute() -> Seen {
            var copy = array
            var max = copy.max()!
            var index = copy.firstIndex(of: max)!
            copy[index] = 0
            while max > 0 {
                index = (index + 1) % copy.count
                copy[index] += 1
                max -= 1
            }
            return Seen(copy)
        }
    }
    
    public init() {
        super.init(inputSource: .raw("2 8 8 5 4 2 3 1 5 5 1 2 15 13 5 14"))
    }
    
    override public func part1() -> String {
        var current = Seen(input.words.integers)
        var seen = Set<Seen>()
        
        repeat {
            seen.insert(current)
            current = current.redistribute()
        } while seen.contains(current) == false
        
        return "\(seen.count)"
    }
    
    override public func part2() -> String {
        var current = Seen(input.words.integers)
        var seen = Dictionary<Seen, Int>()
        
        repeat {
            seen[current] = seen.count
            current = current.redistribute()
        } while seen[current] == nil
        
        return "\(seen.count - seen[current]!)"
    }
    
}

}
