//
//  Day06.swift
//  
//
//  Created by Valentin Wallet on 07/12/2023.
//

struct Race {
    let time: Int
    let distance: Int
    
    func winningPossibilities() -> Int {
        var winPossibilities: Int = 0
        
        for i in 0...time {
            let boatDistance = (self.time - i) * i
            
            if boatDistance > self.distance {
                winPossibilities += 1
            }
        }
        
        return winPossibilities
    }
}

struct Day06: AdventDay {
    let data: String
    
    var races: [Race] {
        let lines = self.data.components(separatedBy: .newlines)
        let times = lines[0]
            .components(separatedBy: .whitespaces)
            .compactMap { Int($0) }
        let distances = lines[1]
            .components(separatedBy: .whitespaces)
            .compactMap { Int($0) }
        
        return times
            .enumerated()
            .map { index, time in
            return Race(time: time, distance: distances[index])
        }
    }
    
    var race: Race {
        let lines = self.data.components(separatedBy: .newlines)
        let time = lines[0]
            .components(separatedBy: .whitespaces)
            .compactMap { component -> String? in
                guard let firstCharacter = component.first,
                      firstCharacter.isNumber else { return nil }
                
                return component
            }
            .joined()
        
        let distance = lines[1]
            .components(separatedBy: .whitespaces)
            .compactMap { component -> String? in
                guard let firstCharacter = component.first,
                      firstCharacter.isNumber else { return nil }
                
                return component
            }
            .joined()
        
        return Race(time: Int(time) ?? 0, distance: Int(distance) ?? 0)
    }
    
    func part1() -> Any {
        return self
            .races
            .map { race in
                race.winningPossibilities()
            }
            .reduce(1, *)
    }
    
    func part2() -> Any {
        return self.race.winningPossibilities()
    }
}
