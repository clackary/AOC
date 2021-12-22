//
//  Point.swift
//  AOC
//
//  Created by Dave DeLong on 12/24/18.
//  Copyright © 2018 Dave DeLong. All rights reserved.
//

import Foundation

public protocol PointProtocol: Hashable, CustomStringConvertible {
    associatedtype Vector: VectorProtocol
    associatedtype Span: SpanProtocol where Span.Point == Self
    
    static var numberOfComponents: Int { get }
    var components: Array<Int> { get }
    init(_ components: Array<Int>)
}

public extension PointProtocol {
    
    var description: String {
        return "(" + components.map(\.description).joined(separator: ", ") + ")"
    }
    
}

public extension PointProtocol {
    
    private static func all<C: Collection>(between lower: C, and upper: C) -> Array<Array<Int>> where C.Element == Int {
        guard lower.count == upper.count else { return [] }
        guard let l = lower.first, let u = upper.first else { return [] }
        
        let remainder = all(between: lower.dropFirst(), and: upper.dropFirst())
        
        let range = min(l, u)...max(l, u)
        if remainder.isEmpty { return range.map { [$0] } }
        
        return range.flatMap { prefix -> Array<Array<Int>> in
            remainder.map { [prefix] + $0 }
        }
    }
    
    static func all(between lower: Self, and upper: Self) -> Array<Self> {
        let combos = all(between: lower.components, and: upper.components)
        return combos.map(Self.init(_:))
    }
    
    static func extremes<C: Collection>(of positions: C) -> (Self, Self) where C.Element == Self {
        var mins = Array(repeating: Int.max, count: numberOfComponents)
        var maxs = Array(repeating: Int.min, count: numberOfComponents)
        
        for p in positions {
            for i in 0 ..< numberOfComponents {
                mins[i] = min(mins[i], p.components[i])
                maxs[i] = max(maxs[i], p.components[i])
            }
        }
        
        return (Self.init(mins), Self.init(maxs))
    }
    
    static var zero: Self {
        let ints = Array(repeating: 0, count: self.numberOfComponents)
        return Self.init(ints)
    }
    
    static func +(lhs: Self, rhs: Vector) -> Self {
        guard numberOfComponents == Vector.numberOfComponents else {
            fatalError("Cannot add a Vector\(Vector.numberOfComponents) to a Point\(numberOfComponents)")
        }
        let new = zip(lhs.components, rhs.components).map { $0 + $1 }
        return Self.init(new)
    }
    
    static func +=(lhs: inout Self, rhs: Vector) {
        lhs = lhs + rhs
    }
    
    static func -(lhs: Self, rhs: Vector) -> Self {
        return lhs + -rhs
    }
    
    static func -=(lhs: inout Self, rhs: Vector) {
        lhs = lhs - rhs
    }
    
    static func +(lhs: Self, rhs: Self) -> Self {
        let new = zip(lhs.components, rhs.components).map { $0 + $1 }
        return Self.init(new)
    }
    
    static func -(lhs: Self, rhs: Self) -> Self {
        let new = zip(lhs.components, rhs.components).map { $0 - $1 }
        return Self.init(new)
    }
    
    static func *(lhs: Self, rhs: Int) -> Self {
        let new = lhs.components.map { $0 * rhs }
        return Self.init(new)
    }
    
    static func *=(lhs: inout Self, rhs: Int) {
        lhs = lhs * rhs
    }
    
    init(_ source: String) {
        let matches = Regex.integers.matches(in: source)
        let ints = matches.compactMap { match -> Int? in
            guard let piece = match[1] else { return nil }
            return Int(piece)
        }
        self.init(ints)
    }
    
    func manhattanDistance(to other: Self) -> Int {
        let pairs = zip(components, other.components)
        return pairs.reduce(0) { $0 + abs($1.0 - $1.1) }
    }
    
    func allSurroundingPoints() -> Array<Self> {
        let combos = self.combos(around: components)
        return combos.map(Self.init(_:)).filter { $0 != self }
    }
    
    private func combos<C: Collection>(around: C) -> Array<Array<Int>> where C.Element == Int {
        guard let f = around.first else { return [] }
        let remainders = combos(around: around.dropFirst())
        
        if remainders.isEmpty {
            return [[f-1], [f], [f+1]]
        }
        let before = remainders.map { [f-1] + $0 }
        let during = remainders.map { [f] + $0 }
        let after = remainders.map { [f+1] + $0 }
        
        return before + during + after
    }
    
    func closestPosition<C: Collection>(in points: C) -> Self? where C.Element == Self {
        
        var closest: Self?
        var distance = Int.max
        
        for other in points {
            let d = manhattanDistance(to: other)
            if d < distance {
                closest = other
                distance = d
            }
        }
        
        return closest
    }
    
    func vector(to other: Self) -> Vector {
        if other == self { return .zero }
        assert(Vector.numberOfComponents == Self.numberOfComponents)
        
        let deltas = zip(components, other.components).map(-)
        return Vector(deltas)
    }
    
    func apply(_ vector: Vector) -> Self {
        assert(Vector.numberOfComponents == Self.numberOfComponents)
        return Self(zip(components, vector.components).map(+))
    }
}

public struct Point2: PointProtocol {
    public typealias Vector = Vector2
    public typealias Span = PointSpan2
    public static let numberOfComponents = 2
    
    public var components: Array<Int> { [x, y] }
    
    public let x: Int
    public let y: Int
    
    public var row: Int { y }
    public var col: Int { x }
    
    public init(x: Int, y: Int) {
        self.x = x; self.y = y
    }
    
    public init(_ components: Array<Int>) {
        guard components.count == Point2.numberOfComponents else {
            fatalError("Invalid components provided to \(#function). Expected \(Point2.numberOfComponents), but got \(components.count)")
        }
        self.init(x: components[0], y: components[1])
    }
    
    public init(row: Int, column: Int) { self.init(x: column, y: row) }
}

public struct Point3: PointProtocol {
    public typealias Vector = Vector3
    public typealias Span = PointSpan3
    public static let numberOfComponents = 3
    
    public var components: Array<Int> { [x, y, z] }
    
    public let x: Int
    public let y: Int
    public let z: Int
    
    public init(_ components: Array<Int>) {
        guard components.count == Point3.numberOfComponents else {
            fatalError("Invalid components provided to \(#function). Expected \(Point3.numberOfComponents), but got \(components.count)")
        }
        self.init(x: components[0], y: components[1], z: components[2])
    }
    
    public init(x: Int, y: Int, z: Int) { self.x = x; self.y = y; self.z = z }
}

public struct Point4: PointProtocol {
    public typealias Vector = Vector4
    public typealias Span = PointSpan4
    public static let numberOfComponents = 4
    
    public var components: Array<Int>
    
    public var x: Int { return components[0] }
    public var y: Int { return components[1] }
    public var z: Int { return components[2] }
    public var t: Int { return components[3] }
    
    public init(_ components: Array<Int>) {
        guard components.count == Point4.numberOfComponents else {
            fatalError("Invalid components provided to \(#function). Expected \(Point4.numberOfComponents), but got \(components.count)")
        }
        self.components = components
    }
    
    public init(x: Int, y: Int, z: Int, t: Int) { self.init([x, y, z, t]) }
}
