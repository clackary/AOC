//
//  Day2.swift
//  test
//
//  Created by Dave DeLong on 12/23/17.
//  Copyright © 2017 Dave DeLong. All rights reserved.
//

class Day2: Day {
        
    override func part1() -> String {
        let rawLines = input.lines.raw
        
        // this groups the lines by the number of repeated characters
        // so b[1] contains all the lines that have a character that does not repeat
        // b[2] contains all the lines with a character that appears twice
        // b[3] contains all the lines with a character that appears 3 times, etc
        let b = Bucketize(rawLines, in: { $0.countElements().values })
        let c = (b[2] ?? []).count * (b[3] ?? []).count
        return "\(c)"
    }

    override func part2() -> String {
        let linesOfCharacters = input.lines.characters // Array<Array<Character>>
        
        for (index, line) in linesOfCharacters.indexed() {
            let next = linesOfCharacters.index(after: index)
            
            for search in linesOfCharacters[next...] {
                let z = Array(zip(line, search))
                let (matchingCharacters, nonMatchingCharacters) = z.partition(by: { $0.0 == $0.1 })
                
                if nonMatchingCharacters.count == 1 {
                    return String(matchingCharacters.map { $0.0 })
                }
            }
        }
        fatalError("unreachable")
    }
    
}
