//
//  Day6.swift
//  AOC2022
//
//  Created by Dave DeLong on 12/16/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day6: Day {
    typealias Part1 = Int
    typealias Part2 = Int
    
    static var rawInput: String? { nil }

    func run() async throws -> (Part1, Part2) {
        let p1 = try await part1()
        let p2 = try await part2()
        return (p1, p2)
    }

    func part1() async throws -> Part1 {
        let markerWidth = 4
        var result: Int = 0

        for i in 0..<(input().raw.count - markerWidth) {
            if Set(input().raw[i..<i+markerWidth]).count == markerWidth {
                result = i + markerWidth
                break
            }
        }

        return result
    }

    func part2() async throws -> Part2 {
        let markerWidth = 14
        var result: Int = 0

        for i in 0..<(input().raw.count - markerWidth) {
            if Set(input().raw[i..<i+markerWidth]).count == markerWidth {
                result = i + markerWidth
                break
            }
        }

        return result
    }
}

extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>)               -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}
