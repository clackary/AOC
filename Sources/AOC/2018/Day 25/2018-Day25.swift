//
//  Day25.swift
//  test
//
//  Created by Dave DeLong on 12/22/17.
//  Copyright © 2017 Dave DeLong. All rights reserved.
//

extension Year2018 {

    public class Day25: Day {
        
        typealias Constellation = Set<Point4>
        
        public init() { super.init(inputSource: .file(#file)) }
        
        lazy var points: Set<Point4> = {
            return Set(input.lines.raw.map { Point4($0) })
        }()
        
        private func constellation(including point: Point4, all remaining: inout Set<Point4>) -> Constellation {
            var constellation = Set([point])
            var consider = [point]
            
            remaining.remove(point)
            
            while let point = consider.popLast() {
                let nearby = remaining.filter { $0.manhattanDistance(to: point) <= 3 }
                remaining.subtract(nearby)
                consider.append(contentsOf: nearby)
                constellation.formUnion(nearby)
            }
            return constellation
        }
        
        override public func part1() -> String {
            var all = points
            
            var constellations = Array<Constellation>()
            while let next = all.randomElement() {
                let c = constellation(including: next, all: &all)
                constellations.append(c)
            }
            
            return "\(constellations.count)"
        }
        
        override public func part2() -> String {
            return ""
        }
        
    }

}
