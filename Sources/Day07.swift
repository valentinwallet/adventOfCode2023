//
//  Day07.swift
//
//
//  Created by Valentin Wallet on 08/12/2023.
//

enum HandType: Equatable {
    case five
    case square(jokerNumber: Int)
    case full(jokerNumber: Int)
    case three(jokerNumber: Int)
    case two(jokerNumber: Int)
    case one(jokerNumber: Int)
    case noPairs(jokerNumber: Int)
    
    var comparisonValue: Int {
        switch self {
        case .five:
            return 7
        case .square(let jokerNumber):
            return 6 + jokerNumber
        case .full(let jokerNumber):
            return 5 + jokerNumber
        case .three(let jokerNumber):
            return 4 + jokerNumber
        case .two(let jokerNumber):
            return 3 + jokerNumber
        case .one(let jokerNumber):
            return 2 + jokerNumber
        case .noPairs(let jokerNumber):
            return 1 + jokerNumber
        }
    }
    
    init(hand: String, jokerAllowed: Bool) {
        switch Self.countSameCards(hand: hand, jokerAllowed: jokerAllowed) {
        case (5, 0, _):
            self = .five
        case (4, 0, let jokerNumber):
            self = .square(jokerNumber: jokerNumber)
        case (3, 2, let jokerNumber):
            self = .full(jokerNumber: jokerNumber)
        case (3, 0, let jokerNumber):
            self = .three(jokerNumber: jokerNumber)
        case (2, 2, let jokerNumber):
            self = .two(jokerNumber: jokerNumber)
        case (2, 0, let jokerNumber):
            self = .one(jokerNumber: jokerNumber)
        case (0, 0, let jokerNumber):
            self = .noPairs(jokerNumber: jokerNumber)
        default:
            self = .noPairs(jokerNumber: 0)
        }
    }
    
    private static func countSameCards(hand: String, jokerAllowed: Bool) -> (firstPair: Int, secondPair: Int, jokerNumber: Int) {
        var dict: [Character: Int] = [:]
        var jokerNumber = 0
        
        for char in hand {
            if dict[char] == nil {
                dict[char] = 1
            } else if let value = dict[char] {
                dict[char] = value + 1
            }
        }
        
        let pairs = dict
            .filter { $0.value >= 2 }
            .sorted { left, right in
                if left.value == right.value {
                    return left.key == "J" ? false : true
                }
                
                return left.value > right.value
            }
        
        jokerNumber += dict["J"] ?? 0

        switch pairs.count {
        case 2:
            let firstPair = pairs.compactMap { Int($0.value) }[0]
            let secondPair = pairs.compactMap { Int($0.value) }[1]
            
            if pairs.first?.key != "J",
               pairs.first?.value == 2,
               jokerNumber > 0 {
                jokerNumber += 1
            }
            
            if pairs.first?.key == "J",
               pairs.first?.value == 3 {
                jokerNumber -= 1
            }
            
            return (firstPair: firstPair, secondPair: secondPair, jokerNumber: jokerAllowed ? jokerNumber : 0)
        case 1:
            let onlyPair = pairs.compactMap { Int($0.value) }[0]
            
            if pairs.first?.key != "J",
               jokerNumber > 0 {
                if let firstPairValue = pairs.first?.value,
                   firstPairValue == 2 || firstPairValue == 3 {
                    jokerNumber += 1
                }
            }
            
            if pairs.first?.key == "J" {
                switch pairs.first?.value {
                case 4:
                    jokerNumber = 1
                case 3:
                    jokerNumber -= 1
                default:
                    break
                }
            }
            
            return (firstPair: onlyPair, secondPair: 0, jokerNumber: jokerAllowed ? jokerNumber : 0)
        default:
            return (firstPair: 0, secondPair: 0, jokerNumber: 0)
        }
    }
    
    static func == (lhs: HandType, rhs: HandType) -> Bool {
        return lhs.comparisonValue == rhs.comparisonValue
    }
}

struct PokerHand: Comparable {
    let hand: String
    let price: Int
    let handType: HandType
    let jokerAllowed: Bool
    let cardValues: [Character: Int]
    
    init(hand: String, price: Int, cardValues: [Character: Int], jokerAllowed: Bool) {
        self.hand = hand
        self.price = price
        self.handType = HandType(hand: hand, jokerAllowed: jokerAllowed)
        self.jokerAllowed = jokerAllowed
        self.cardValues = cardValues
    }
    
    static func < (lhs: PokerHand, rhs: PokerHand) -> Bool {
        if lhs.handType == rhs.handType {
            for i in 0...4 {
                let leftCard = lhs.hand[i]
                let rightCard = rhs.hand[i]
                let cardValues = lhs.cardValues
                
                if cardValues[leftCard] != cardValues[rightCard] {
                    return cardValues[leftCard] ?? 0 < cardValues[rightCard] ?? 0
                }
            }
        }
        
        return lhs.handType.comparisonValue < rhs.handType.comparisonValue
    }
    
    static func == (lhs: PokerHand, rhs: PokerHand) -> Bool {
        return lhs.handType == rhs.handType
    }
}

struct Day07: AdventDay {
    var data: String
    
    func getCardValues(isJokerAllowed: Bool = false) -> [Character: Int] {
        return [
            "A": 13,
            "K": 12,
            "Q": 11,
            "J": isJokerAllowed ? 0 : 10,
            "T": 9,
            "9": 8,
            "8": 7,
            "7": 6,
            "6": 5,
            "5": 4,
            "4": 3,
            "3": 2,
            "2": 1
        ]
    }
    
    func getHands(isJokerAllowed: Bool = false) -> [PokerHand] {
        return self.data
            .components(separatedBy: .newlines)
            .compactMap { line in
                guard !line.isEmpty else { return nil }
                
                let handComponents = line.components(separatedBy: .whitespaces)
                
                return PokerHand(hand: handComponents[0],
                                 price: Int(handComponents[1])!,
                                 cardValues: self.getCardValues(isJokerAllowed: isJokerAllowed),
                                 jokerAllowed: isJokerAllowed)
            }
    }
    
    func part1() -> Any {
        let sortedHands = self.getHands()
            .sorted(by: >)
        var rank = sortedHands.count
        var totalWinning = 0
        
        for sortedHand in sortedHands {
            totalWinning += sortedHand.price * rank
            rank -= 1
        }
        
        return totalWinning
    }
    
    func part2() -> Any {
        let sortedHands = self.getHands(isJokerAllowed: true)
            .sorted(by: >)
        var rank = sortedHands.count
        var totalWinning = 0
        
        for sortedHand in sortedHands {
            totalWinning += sortedHand.price * rank
            rank -= 1
        }
        
        return totalWinning
    }
}
