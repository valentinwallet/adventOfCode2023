//
//  Day04.swift
//
//
//  Created by Valentin Wallet on 04/12/2023.
//

import Foundation

struct Card {
    let id: Int
    let left: [Int]
    let right: [Int]
    
    func getMatches() -> Int {
        var matches = 0
        
        for nb in self.left {
            if right.contains(nb) {
                matches += 1
            }
        }
        
        return matches
    }
    
    func calculatePoints() -> Int {
        var matches = -1
        
        matches += self.getMatches()
        
        if matches >= 0 {
            let points = powf(Float(2), Float(matches))
            return Int(points)
        } else {
            return 0
        }
    }
}

struct Day04: AdventDay {
    var data: String
    
    private var cards: [Card] {
        return self.data
            .components(separatedBy: .newlines)
            .enumerated()
            .compactMap { index, line in
                guard !line.isEmpty else { return nil }
                
                let left = line
                    .components(separatedBy: "|")[0]
                    .components(separatedBy: ":")[1]
                    .components(separatedBy: .whitespaces)
                    .compactMap { Int($0) }
                
                let right = line
                    .components(separatedBy: "|")[1]
                    .components(separatedBy: .whitespaces)
                    .compactMap { Int($0) }

                return Card(id: index, left: left, right: right)
            }
    }
    
    func part1() -> Any {
        return self.cards
            .map { $0.calculatePoints() }
            .reduce(0, +)
    }
    
    func part2() -> Any {
        var copies = [Int](repeating: 1, count: self.cards.count)
        
        for card in cards where card.getMatches() > 0 {
            for i in card.id + 1 ... card.id + card.getMatches() {
                copies[i] += copies[card.id]
            }
        }
        
        return copies.reduce(0, +)
    }
}
