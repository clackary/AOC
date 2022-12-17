//
//  Test2022.swift
//  AOCTests
//
//  Created by Dave DeLong on 12/16/22.
//  Copyright © 2022 Dave DeLong. All rights reserved.
//

import XCTest
@testable import AOC2022

class Test2022: XCTestCase {

    func testDay1() async throws {
        let d = Day1()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, 71471)
        XCTAssertEqual(p2, 211189)
    }

    func testDay2() async throws {
        let d = Day2()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, 11666)
        XCTAssertEqual(p2, 12767)
    }

    func testDay3() async throws {
        let d = Day3()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, 8243)
        XCTAssertEqual(p2, 2631)
    }

    func testDay4() async throws {
        let d = Day4()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, 490)
        XCTAssertEqual(p2, 921)
    }

    func testDay5() async throws {
        let d = Day5()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "QNNTGTPFN")
        XCTAssertEqual(p2, "GGNPJBTTR")
    }

    func testDay6() async throws {
        let d = Day6()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, 1238)
        XCTAssertEqual(p2, 3037)
    }

    func testDay7() async throws {
        let d = Day7()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, 1182909)
        XCTAssertEqual(p2, 2832508)
    }

    func testDay8() async throws {
        let d = Day8()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, 1849)
        XCTAssertEqual(p2, 201600)
    }

    func testDay9() async throws {
        let d = Day9()
        let (p1, p2) = try await d.run()

        var r = Day9.RopeSegment(0, 0)
        r.step(toward: [.left, .up])
        XCTAssertTrue(r.position.x == -1)
        XCTAssertTrue(r.position.y == 1)
        XCTAssertTrue(r.coordHistory.count == 2)

        XCTAssertEqual(p1, 6464)
        XCTAssertEqual(p2, 2604)
    }

    func testDay10() async throws {
        let d = Day10()
        let (p1, p2) = try await d.run()

        var cpu: Day10.CPU = Day10.CPU()
        XCTAssertEqual(cpu.x, 1)
        XCTAssertEqual(cpu.cycleCount, 0)
        cpu.resolveInstruction("noop")
        XCTAssertEqual(cpu.cycleCount, 1)
        XCTAssertEqual(cpu.x, 1)
        cpu.resolveInstruction("addx 3")
        XCTAssertEqual(cpu.cycleCount, 3)
        XCTAssertEqual(cpu.x, 4)
        XCTAssertEqual(cpu.signalStrength(afterCycle: 2), 2)
        XCTAssertEqual(cpu.signalStrength(afterCycle: 3), 12)
        cpu.resolveInstruction("addx -5")
        XCTAssertEqual(cpu.cycleCount, 5)
        XCTAssertEqual(cpu.x, -1)
        XCTAssertEqual(cpu.signalStrength(afterCycle: 4), 16)
        XCTAssertEqual(cpu.signalStrength(duringCycle: 5), 20)
        XCTAssertEqual(cpu.signalStrength(afterCycle: 5), -5)

        XCTAssertEqual(cpu.xValue(duringCycle: 1), 1)
        XCTAssertEqual(cpu.xValue(duringCycle: 2), 1)
        XCTAssertEqual(cpu.xValue(duringCycle: 3), 1)
        XCTAssertEqual(cpu.xValue(duringCycle: 4), 4)
        XCTAssertEqual(cpu.xValue(duringCycle: 5), 4)
        XCTAssertEqual(cpu.xRange(duringCycle: 2), 0...2)
        XCTAssertEqual(cpu.xRange(duringCycle: 4), 3...5)

        XCTAssertEqual(p1, 13760)
        XCTAssertEqual(p2, "RFKZCPEF")
    }

    func testDay11() async throws {
        let d = Day11()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay12() async throws {
        let d = Day12()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay13() async throws {
        let d = Day13()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay14() async throws {
        let d = Day14()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay15() async throws {
        let d = Day15()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay16() async throws {
        let d = Day16()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay17() async throws {
        let d = Day17()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay18() async throws {
        let d = Day18()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay19() async throws {
        let d = Day19()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay20() async throws {
        let d = Day20()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay21() async throws {
        let d = Day21()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay22() async throws {
        let d = Day22()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay23() async throws {
        let d = Day23()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay24() async throws {
        let d = Day24()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay25() async throws {
        let d = Day25()
        let (p1, p2) = try await d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }
}
