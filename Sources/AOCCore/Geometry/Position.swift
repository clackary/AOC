//
//  Position.swift
//  test
//
//  Created by Dave DeLong on 12/22/17.
//  Copyright © 2017 Dave DeLong. All rights reserved.
//

public typealias Position = Point2
public typealias XY = Point2

public extension Point2 {
    
    static func all(in xRange: ClosedRange<Int>, _ yRange: ClosedRange<Int>) -> Array<Position> {
        return yRange.flatMap { y -> Array<Position> in
            return xRange.map { Position(x: $0, y: y) }
        }
    }
    
    static func extremes<C: Collection>(of positions: C) -> (Position, Position) where C.Element == Position {
        var minX = Int.max
        var maxX = Int.min
        
        var minY = Int.max
        var maxY = Int.min
        
        for p in positions {
            minX = min(minX, p.x)
            minY = min(minY, p.y)
            maxX = max(maxX, p.x)
            maxY = max(maxY, p.y)
        }
        
        return (Position(x: minX, y: minY), Position(x: maxX, y: maxY))
    }
    
    static func edges(of xRange: ClosedRange<Int>, _ yRange: ClosedRange<Int>) -> Set<Position> {
        return Set(
            xRange.map { Position(x: $0, y: yRange.lowerBound) } +
                xRange.map { Position(x: $0, y: yRange.upperBound) } +
                yRange.map { Position(x: xRange.lowerBound, y: $0) } +
                yRange.map { Position(x: xRange.upperBound, y: $0) }
        )
    }
    
    func move(_ heading: Heading) -> Position {
        switch heading {
            case .north: return Position(x: x, y: y-1)
            case .south: return Position(x: x, y: y+1)
            case .east: return Position(x: x+1, y: y)
            case .west: return Position(x: x-1, y: y)
        }
    }
    
    func surroundingPositions(includingDiagonals: Bool = false) -> Array<Position> {
        var surround = [
            Position(x: x, y: y-1),
            Position(x: x, y: y+1),
            Position(x: x+1, y: y),
            Position(x: x-1, y: y),
        ]
        if includingDiagonals == true {
            surround.append(contentsOf: [
                Position(x: x-1, y: y-1),
                Position(x: x+1, y: y-1),
                Position(x: x-1, y: y+1),
                Position(x: x+1, y: y+1),
            ])
        }
        return surround
    }
    
    func neighbors() -> Array<Position> {
        return [
            move(.north),
            move(.east),
            move(.south),
            move(.west)
        ]
    }
    
    func closestPosition<C: Collection>(in points: C) -> Position? where C.Element == Position {
        
        var closest: Position?
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
    
}

extension Array where Element: RandomAccessCollection, Element.Index == Int {
    public subscript(key: Position) -> Element.Element? {
        if key.y < 0 { return nil }
        if key.y >= self.count { return nil }
        let row = self[key.y]
        
        if key.x < 0 { return nil }
        if key.x >= row.count { return nil }
        return row[key.x]
    }
}
