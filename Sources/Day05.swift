//
//  Day05.swift
//
//
//  Created by Valentin Wallet on 05/12/2023.
//

struct Map {
    var destinations: [Int]
    var sources: [Int]
    var ranges: [Int]
    
    init(destinations: [Int], sources: [Int], ranges: [Int]) {
        self.destinations = destinations
        self.sources = sources
        self.ranges = ranges
    }
    
    func getDestinationValue(for number: Int) -> Int {
        for i in 0 ..< destinations.count {
            let sourceRange = self.sources[i] ... self.sources[i] + (self.ranges[i] - 1)
            
            if sourceRange.contains(number) {
                return self.destinations[i] + (number - sourceRange.lowerBound)
            }
        }
        
        return number
    }
}

struct Day05: AdventDay {
    var data: String
    
    private var maps: [Map] {
        var lines = self.data
            .components(separatedBy: .newlines)
        var maps: [Map] = []
        var currentMap: Map? = nil
        
        lines.removeFirst()
        
        for line in lines {
            if line.contains("map") {
                currentMap = Map(destinations: [], sources: [], ranges: [])
            }
            
            if let firstCharacter = line.first,
               firstCharacter.isNumber {
                let numbers = line
                    .components(separatedBy: " ")
                    .compactMap { Int($0) }
                currentMap?.destinations.append(numbers[0])
                currentMap?.sources.append(numbers[1])
                currentMap?.ranges.append(numbers[2])
            }
            
            if line.isEmpty,
                let map = currentMap {
                maps.append(map)
            }
        }
        
        return maps
    }
    
    func part1() -> Any {
        let seeds = self.data
            .components(separatedBy: .newlines)
            .first!
            .components(separatedBy: ":")[1]
            .components(separatedBy: " ")
            .compactMap { Int($0) }
        var location: Int = 0
        var locations: [Int] = []

        for seed in seeds {
            location = seed
            
            for map in self.maps {
                location = map.getDestinationValue(for: location)
            }
            
            locations.append(location)
        }
        
        return locations
            .min() ?? 0
    }
    
    func part2() async -> Any {
        let seeds = self.data
            .components(separatedBy: .newlines)
            .first!
            .components(separatedBy: ":")[1]
            .components(separatedBy: " ")
            .compactMap { Int($0) }
        let seedsRange = stride(from: 0, to: seeds.count, by: 2)
            .map { Array(seeds[$0..<$0+2]) }
            .map { seeds in
                return seeds[0]...(seeds[0] + seeds[1] - 1)
            }
        
        let locations = await withTaskGroup(of: [Int].self, returning: [Int].self) { group  in
            for seedRange in seedsRange {
                group.addTask {
                    return self.getLocations(for: seedRange)
                }
            }
            
            var locations: [Int] = []
            
            for await result in group {
                locations.append(contentsOf: result)
            }
            
            return locations
        }
        
        return locations
            .min() ?? 0
    }
}

private extension Day05 {
    private func getLocations(for seedRange: ClosedRange<Int>) -> [Int] {
        let maps = self.maps
        var locations: [Int] = []
        var location: Int = 0
        
        for seed in seedRange {
            location = seed
            
            for map in maps {
                location = map.getDestinationValue(for: location)
            }
            
            locations.append(location)
        }
        
        return locations
    }
}


