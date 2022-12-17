//
//  Day8.swift
//  AOC2022
//
//  Created by Dave DeLong on 12/16/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day8: Day {
    typealias Part1 = Int
    typealias Part2 = Int
    
    static var rawInput: String? { nil }

    func run() async throws -> (Part1, Part2) {
        let p1 = try await part1()
        let p2 = try await part2()
        return (p1, p2)
    }

    func part1() async throws -> Part1 {
        let lines = input().lines.raw
        var matrix: [[Int]] = []
        for line in lines {
            matrix.append(line.map({Int(String($0))!}))
        }

        func isVisible(_ x: Int, _ y: Int, length: Int) -> Bool {
            var up: Bool = true
            var down: Bool = true
            var left: Bool = true
            var right: Bool = true

            // Check up
            for u in 0..<x {
                if matrix[u][y] >= matrix[x][y] {
                    up = false
                    break
                }
            }
            // Check down
            for d in (x + 1)..<(length) {
                if matrix[d][y] >= matrix[x][y] {
                    down = false
                    break
                }
            }
            // Check left
            for l in 0..<y {
                if matrix[x][l] >= matrix[x][y] {
                    left = false
                    break
                }
            }
            // Check right
            for r in (y + 1)..<(length) {
                if matrix[x][r] >= matrix[x][y] {
                    right = false
                    break
                }
            }
            return up || down || left || right
        }

        func scenicScore(_ x: Int, _ y: Int, length: Int) -> Int {
            var up: Int = 0
            var down: Int = 0
            var left: Int = 0
            var right: Int = 0

            // Check up
            for u in (0..<x).reversed() {
                up += 1
                if matrix[u][y] >= matrix[x][y] {
                    break
                }
            }
            // Check down
            for d in ((x + 1)..<(length)) {
                down += 1
                if matrix[d][y] >= matrix[x][y] {
                    break
                }
            }
            // Check left
            for l in (0..<y).reversed() {
                left += 1
                if matrix[x][l] >= matrix[x][y] {
                    break
                }
            }
            // Check right
            for r in ((y + 1)..<(length)) {
                right += 1
                if matrix[x][r] >= matrix[x][y] {
                    break
                }
            }
            print("(\(x),\(y): \(up) \(down) \(left) \(right)")
            return up * down * left * right
        }

            var visibleTrees = 0

            for x in matrix.indices {
                for y in matrix[x].indices {
                    let xPosition = Int(x)
                    let yPosition = Int(y)
                    // Check for edges
                    if isEdge(xPosition, yPosition, length: matrix[x].count) {
                        visibleTrees += 1
                        continue
                    }

                    // Check up, down, left, right
                    if isVisible(xPosition, yPosition, length: matrix[x].count) {
                        visibleTrees += 1
                        print("(\(xPosition), \(yPosition)) visible")
                    }
                }
            }

        return visibleTrees
    }

    func part2() async throws -> Part2 {
        let lines = input().lines.raw
        var matrix: [[Int]] = []
        for line in lines {
            matrix.append(line.map({Int(String($0))!}))
        }

        func isVisible(_ x: Int, _ y: Int, length: Int) -> Bool {
            var up: Bool = true
            var down: Bool = true
            var left: Bool = true
            var right: Bool = true

            // Check up
            for u in 0..<x {
                if matrix[u][y] >= matrix[x][y] {
                    up = false
                    break
                }
            }
            // Check down
            for d in (x + 1)..<(length) {
                if matrix[d][y] >= matrix[x][y] {
                    down = false
                    break
                }
            }
            // Check left
            for l in 0..<y {
                if matrix[x][l] >= matrix[x][y] {
                    left = false
                    break
                }
            }
            // Check right
            for r in (y + 1)..<(length) {
                if matrix[x][r] >= matrix[x][y] {
                    right = false
                    break
                }
            }
            return up || down || left || right
        }

        func scenicScore(_ x: Int, _ y: Int, length: Int) -> Int {
            var up: Int = 0
            var down: Int = 0
            var left: Int = 0
            var right: Int = 0

            // Check up
            for u in (0..<x).reversed() {
                up += 1
                if matrix[u][y] >= matrix[x][y] {
                    break
                }
            }
            // Check down
            for d in ((x + 1)..<(length)) {
                down += 1
                if matrix[d][y] >= matrix[x][y] {
                    break
                }
            }
            // Check left
            for l in (0..<y).reversed() {
                left += 1
                if matrix[x][l] >= matrix[x][y] {
                    break
                }
            }
            // Check right
            for r in ((y + 1)..<(length)) {
                right += 1
                if matrix[x][r] >= matrix[x][y] {
                    break
                }
            }
            print("(\(x),\(y): \(up) \(down) \(left) \(right)")
            return up * down * left * right
        }

        var highScenicScore: Int = 0
        for x in matrix.indices {
            for y in matrix[x].indices {
                let score = scenicScore(x, y, length: matrix[x].count)
                if score > highScenicScore {
                    highScenicScore = score
                }
            }
        }

        return highScenicScore
    }

    func isEdge(_ x: Int, _ y: Int, length: Int) -> Bool {
        if x == 0 || y == 0 {
            return true
        }
        if x == length - 1 || y == length - 1 {
            return true
        }
        return false
    }
}
