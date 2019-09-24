//
//  main.swift
//  test
//
//  Created by Dave DeLong on 12/14/17.
//  Copyright © 2017 Dave DeLong. All rights reserved.
//

extension Year2017 {

public class Day15: Day {

    public init() { super.init() }
    
    func match<S1: IteratorProtocol, S2: IteratorProtocol>(a: S1, b: S2, iterations: Int) -> Int where S1.Element == Int, S2.Element == Int {
        var a1 = a; var b1 = b
        return (0 ..< iterations).reduce(0) { (sum, _) in sum + (a1.next()! & 0xFFFF == b1.next()! & 0xFFFF ? 1 : 0) }
    }

    let p1a = sequence(first: 883, next: { ($0 * 16807) % 2147483647 })
    let p1b = sequence(first: 879, next: { ($0 * 48271) % 2147483647 })

    override public func part1() -> String {
        let answer = match(a: p1a, b: p1b, iterations: 40_000_000)
        return "\(answer)"
    }

    override public func part2() -> String {
        let p2a = p1a.lazy.filter { $0 % 4 == 0 }.makeIterator()
        let p2b = p1b.lazy.filter { $0 % 8 == 0 }.makeIterator()
        let answer = match(a: p2a, b: p2b, iterations: 5_000_000)
        return "\(answer)"
    }
    
}

}
