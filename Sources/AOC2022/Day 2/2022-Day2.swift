//
//  Day2.swift
//  AOC2022
//
//  Created by Dave DeLong on 12/16/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

class Day2: Day {
    typealias Part1 = Int
    typealias Part2 = Int
    
    static var rawInput: String? { nil }

    enum Shape {
        case Rock
        case Paper
        case Scissors
    }

    struct Outcome {
        static let loss = 0
        static let draw = 3
        static let win = 6
    }

    struct Play: Comparable {
        let shape: Shape
        let value: Int

        init(shape: Shape) {
            switch shape {
            case .Rock:
                self.shape = .Rock
                self.value = 1
            case .Paper:
                self.shape = .Paper
                self.value = 2
            case .Scissors:
                self.shape = .Scissors
                self.value = 3
            }
        }

        init(str: String) {
            switch str {
            case "A":
                self.shape = .Rock
                self.value = 1
            case "B":
                self.shape = .Paper
                self.value = 2
            case "C":
                self.shape = .Scissors
                self.value = 3
            case "X":
                self.shape = .Rock
                self.value = 1
            case "Y":
                self.shape = .Paper
                self.value = 2
            case "Z":
                self.shape = .Scissors
                self.value = 3
            default:
                print("Unknown input shape.")
                self.shape = .Rock
                self.value = 0
            }
        }

        static func < (lhs: Play, rhs: Play) -> Bool {
            if lhs.shape == .Rock && rhs.shape == .Paper {
                // Rock vs Paper
                return true
            } else if lhs.shape == .Rock && rhs.shape == .Scissors {
                // Rock vs Scissors
                return false
            } else if lhs.shape == .Paper && rhs.shape == .Rock {
                // Paper vs Rock
                return false
            } else if lhs.shape == .Paper && rhs.shape == .Scissors {
                // Paper vs Scissors
                return true
            } else if lhs.shape == .Scissors && rhs.shape == .Rock {
                // Scissors vs Rock
                return true
            } else if lhs.shape == .Scissors && rhs.shape == .Paper {
                // Scissors vs Paper
                return false
            } else {
                return true
            }
        }

        static func == (lhs: Play, rhs: Play) -> Bool {
            return lhs.shape == rhs.shape
        }

        func playToLose() -> Play {
            switch self.shape {
            case .Rock:
                return Play(shape: .Scissors)
            case .Paper:
                return Play(shape: .Rock)
            case .Scissors:
                return Play(shape: .Paper)
            }
        }

        func playToWin() -> Play {
            switch self.shape {
            case .Rock:
                return Play(shape: .Paper)
            case .Paper:
                return Play(shape: .Scissors)
            case .Scissors:
                return Play(shape: .Rock)
            }
        }
    }

    func run() async throws -> (Part1, Part2) {
        let p1 = try await part1()
        let p2 = try await part2()
        return (p1, p2)
    }

    func part1() async throws -> Part1 {
        var array: [(Play, Play)] = []

        for s in input().lines.raw {
            let plays = s.components(separatedBy: .whitespaces)
            if plays.count < 2 {
                continue
            }
            // Part one: both entries are plays
            let player = Play(str: plays[1])
            let opponent = Play(str: plays[0])

            array.append((player, opponent))
        }

        var myScore = 0
        var opponentScore = 0

        for (myPlay, opponentPlay) in array {
            myScore += myPlay.value
            opponentScore += opponentPlay.value
            // Draw
            if myPlay == opponentPlay {
                print("\(myPlay.shape) vs \(opponentPlay.shape) - Draw!")
                myScore += Outcome.draw
                opponentScore += Outcome.draw
                print("Score: \(myScore)")
                continue
            }
            if myPlay > opponentPlay {
                // Player wins
                print("\(myPlay.shape) vs \(opponentPlay.shape) - Win!")
                myScore += Outcome.win
                opponentScore += Outcome.loss
            } else {
                // Player loses
                print("\(myPlay.shape) vs \(opponentPlay.shape) - Loss!")
                myScore += Outcome.loss
                opponentScore += Outcome.win
            }
            print("Score: \(myScore)")
        }

        // Part one: What would your total score be if everything goes exactly according to your strategy guide?
        return myScore
    }

    func part2() async throws -> Part2 {
        var array: [(Play, Play)] = []
        for s in input().lines.raw {
            let plays = s.components(separatedBy: .whitespaces)
            if plays.count < 2 {
                continue
            }

            // Part two: First entry is opponent play, second entry is the outcome.
            let opponent = Play(str: plays[0])
            var player: Play

            switch plays[1] {
            case "X": // Lose
                player = opponent.playToLose()
            case "Y": // Draw
                player = opponent
            case "Z": // Win
                player = opponent.playToWin()
            default: fatalError()
            }

            array.append((player, opponent))
        }

        var myScore = 0
        var opponentScore = 0

        for (myPlay, opponentPlay) in array {
            myScore += myPlay.value
            opponentScore += opponentPlay.value
            // Draw
            if myPlay == opponentPlay {
                print("\(myPlay.shape) vs \(opponentPlay.shape) - Draw!")
                myScore += Outcome.draw
                opponentScore += Outcome.draw
                print("Score: \(myScore)")
                continue
            }
            if myPlay > opponentPlay {
                // Player wins
                print("\(myPlay.shape) vs \(opponentPlay.shape) - Win!")
                myScore += Outcome.win
                opponentScore += Outcome.loss
            } else {
                // Player loses
                print("\(myPlay.shape) vs \(opponentPlay.shape) - Loss!")
                myScore += Outcome.loss
                opponentScore += Outcome.win
            }
            print("Score: \(myScore)")
        }

        return myScore
    }
}
