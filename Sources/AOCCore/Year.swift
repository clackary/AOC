//
//  File.swift
//  
//
//  Created by Dave DeLong on 11/14/19.
//

import Foundation
import ObjectiveC

public protocol Year {
    
    static var days: Array<any Day> { get }
    
}

extension Year {
    
    public static func today() -> any Day {
        var c = Calendar(identifier: .gregorian)
        c.timeZone = TimeZone(identifier: "America/New_York")!
        let dc = c.dateComponents([.month, .day], from: Date())
        guard dc.month == 12 else { return InvalidDay(number: 0) }
        guard let day = dc.day else { return InvalidDay(number: 0) }
        return self.day(day)
    }
    
    public static func day(_ number: Int) -> any Day {
        let idx = number - 1
        guard days.indices.contains(idx) else { return InvalidDay(number: number) }
        return days[idx]
    }
    
}

private struct InvalidDay: Day {
    let number: Int
}
