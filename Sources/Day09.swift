//
//  Day09.swift
//
//
//  Created by Valentin Wallet on 09/12/2023.
//

struct Day09: AdventDay {
    var data: String
    
    var lines: [[Int]] {
        return self.data
            .components(separatedBy: .newlines)
            .map { $0.components(separatedBy: .whitespaces) }
            .map { $0.compactMap { Int($0) } }
    }
    
    func createRecords(for line: [Int]) -> [[Int]] {
        var records: [[Int]] = [line]
        var i = 0
        var j = 1
        var h = 0
        
        while true {
            i = 0
            j = 1
            
            if records[h].allSatisfy({ $0 == 0 }) {
                break
            } else {
                records.append([])
            }
            
            while (i < records[h].count && j < records[h].count) {
                let difference = records[h][j] - records[h][i]
                
                records[h + 1].append(difference)
                
                i += 1
                j += 1
            }
            
            h += 1
        }
        
        return records
    }
    
    func getValueTopRight(for records: [[Int]]) -> Int {
        var h = records.count - 1
        var newRecords = records
        
        while h >= 0 {
            if h == records.count - 1 {
                newRecords[h].append(0)
            } else {
                let currentLineLast = newRecords[h].last ?? 0
                let pastLineLast = newRecords[h + 1].last ?? 0
                newRecords[h].append(currentLineLast + pastLineLast)
            }
            
            h -= 1
        }
        
        return newRecords.first?.last ?? 0
    }
    
    func getValueTopLeft(for records: [[Int]]) -> Int {
        var h = records.count - 1
        var newRecords = records
        
        while h >= 0 {
            if h == records.count - 1 {
                newRecords[h].insert(0, at: 0)
            } else {
                let currentLineFirst = newRecords[h].first ?? 0
                let pastLineFirst = newRecords[h + 1].first ?? 0
                
                newRecords[h].insert(currentLineFirst - pastLineFirst, at: 0)
            }
            
            h -= 1
        }
        
        return newRecords.first?.first ?? 0
    }
    
    func part1() -> Any {
        self.lines
            .map {
                let records = self.createRecords(for: $0)
                return self.getValueTopRight(for: records)
            }
            .reduce(0, +)
    }
    
    func part2() -> Any {
        self.lines
            .map {
                let records = self.createRecords(for: $0)
                return self.getValueTopLeft(for: records)
            }
            .reduce(0, +)
    }
}
