//
//  Day9.swift
//  AOC2022
//
//  Created by Dave DeLong on 12/16/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day9: Day {
    typealias Part1 = Int
    typealias Part2 = Int

    var instructions: [Instruction] = []

    func run() async throws -> (Part1, Part2) {
        for line in input().lines.raw {
            guard !line.isEmpty else {continue}
            let comps = line.components(separatedBy: .whitespaces)
            let dir = Direction(comps.first!)
            let steps = Int(comps.last!)!
            instructions.append(Instruction(direction: dir, steps: steps))
        }

        let p1 = try await part1()
        let p2 = try await part2()
        return (p1, p2)
    }

    func part1() async throws -> Part1 {
        var rope: Rope = Rope(0, 0, segmentCount: 2)

        for instruction in instructions {
            rope.moveHead(by: instruction)
        }

        return rope.tail.coordHistory.count
    }

    func part2() async throws -> Part2 {
        var rope: Rope = Rope(0, 0, segmentCount: 10)

        for instruction in instructions {
            rope.moveHead(by: instruction)
        }

        return rope.tail.coordHistory.count
    }

    struct Rope {
        var segments: [RopeSegment]

        var head: RopeSegment { segments.first! }
        var tail: RopeSegment { segments.last! }

        init(_ x: Int, _ y: Int, segmentCount: Int) {
            segments = Array(repeating: RopeSegment(x, y), count: segmentCount)
        }

        mutating func moveHead(by instruction: Instruction) {
            for _ in 0..<instruction.steps {
                segments[0].step(toward: [instruction.direction])
                for i in 1..<segments.count {
                    if segments[i].inRangeOf(segments[i-1]) {
                        continue
                    } else {
                        segments[i].moveWithinRangeOf(segments[i-1])
                    }
                }
            }
        }
    }

    struct Position: Hashable {
        var x: Int
        var y: Int
    }

    struct RopeSegment {
        var position: Position
        var coordHistory: Set<Position>

        init(_ x: Int, _ y: Int) {
            self.position = Position(x: x, y: y)
            self.coordHistory = []
            coordHistory.insert(position)
        }

        mutating func step(toward: Direction) {
            switch toward {
            case .down:
                position.y -= 1
            case .up:
                position.y += 1
            case .left:
                position.x -= 1
            case .right:
                position.x += 1
            }
            coordHistory.insert(position)
        }

        mutating func step(toward: [Direction]) {
            for t in toward {
                switch t {
                case .down:
                    position.y -= 1
                case .up:
                    position.y += 1
                case .left:
                    position.x -= 1
                case .right:
                    position.x += 1
                }
            }
            coordHistory.insert(position)
        }

        func inRangeOf(_ other: RopeSegment) -> Bool {
            if abs(position.x - other.position.x) > 1 || abs(position.y - other.position.y) > 1 {
                return false
            }
            return true
        }

        mutating func moveWithinRangeOf(_ other: RopeSegment) {
            let xDelta = abs(position.x - other.position.x)
            let yDelta = abs(position.y - other.position.y)

            if xDelta >= 1 && yDelta >= 1 {
                // Move diagonally
                if position.x > other.position.x && position.y < other.position.y {
                    step(toward: [.left, .up])
                } else if position.x < other.position.x && position.y < other.position.y {
                    step(toward: [.right, .up])
                } else if position.x > other.position.x && position.y > other.position.y {
                    step(toward: [.left, .down])
                } else if position.x < other.position.x && position.y > other.position.y {
                    step(toward: [.right, .down])
                }
            } else if xDelta > 1 && yDelta == 0 {
                // Move horizontally
                if position.x < other.position.x {
                    step(toward: .right)
                    return
                } else {
                    step(toward: .left)
                    return
                }
            } else if xDelta == 0 && yDelta > 1 {
                // Move vertically
                if position.y > other.position.y {
                    step(toward: .down)
                    return
                } else {
                    step(toward: .up)
                    return
                }
            }
        }
    }

    enum Direction {
        case up, down, left, right

        init(_ s: String) {
            switch s {
            case "U":
                self = .up
            case "D":
                self = .down
            case "L":
                self = .left
            case "R":
                self = .right
            default:
                fatalError()
            }
        }
    }

    struct Instruction {
        var direction: Direction
        var steps: Int
    }
}
