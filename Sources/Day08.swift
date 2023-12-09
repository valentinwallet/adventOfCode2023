//
//  Day08.swift
//
//
//  Created by Valentin Wallet on 09/12/2023.
//

struct Document {
    let instructions: String
    let map: [String: (left: String, right: String)]
}

struct Day08: AdventDay {
    var data: String
    
    var document: Document {
        let lines = self.data
            .components(separatedBy: .newlines)
            .compactMap { $0.isEmpty ? nil : $0 }
        let instructions = lines[0]
        var map: [String: (left: String, right: String)] = [:]
        let directions = lines[1..<lines.count]
            .map { line in
                let name = line.components(separatedBy: "=")[0]
                    .filter { $0.isLetter || $0.isNumber }
                let directions = line
                    .components(separatedBy: "=")[1]
                    .components(separatedBy: ",")
                    .map { $0.filter { $0.isLetter || $0.isNumber } }
                
                return [name, directions[0], directions[1]]
            }
        
        for direction in directions {
            map[direction[0]] = (left: direction[1], right: direction[2])
        }
        
        return Document(instructions: instructions, 
                        map: map)
    }
    
    private func calculateSteps(for start: (left: String, right: String), document: Document, target: (String) -> Bool) -> Int {
        var currentDestination = start
        var found = false
        var steps = 0
        
        while found != true {
            for instruction in document.instructions {
                switch instruction {
                case "L":
                    if target(currentDestination.left) {
                        found = true
                    }
                    
                    currentDestination = document.map[currentDestination.left]!
                case "R":
                    if target(currentDestination.right) {
                        found = true
                    }
                    
                    currentDestination = document.map[currentDestination.right]!
                default:
                    break
                }
                
                if found {
                    steps += 1
                    break
                } else {
                    steps += 1
                }
            }
        }
        
        return steps
    }
    
    func part1() -> Any {
        let document = self.document
        let start = self.document.map["AAA"]!
        
        return self.calculateSteps(for: start, 
                                   document: document, 
                                   target: { $0 == "ZZZ" })
    }
    
    func part2() -> Any {
        let document = self.document
        let starts = self.document
            .map
            .filter { $0.key.last == "A" }
        
        let allPaths = starts.map { self.calculateSteps(for: $0.value,
                                                        document: document,
                                                        target: { $0.last == "Z" }) }
        
        return allPaths.reduce(1) { Math.LCM(number1: $0, number2: $1) }
    }
}
