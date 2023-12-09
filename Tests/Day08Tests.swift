//
//  Day08Tests.swift
//
//
//  Created by Valentin Wallet on 09/12/2023.
//

import XCTest
@testable import AdventOfCode

final class Day08Tests: XCTestCase {
    let testData1 = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """
    
    let testData2 = """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """
    
    let testData3 = """
    LR

    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    """
    
    func testPart1_test_data1() throws {
        let challenge = Day08(data: self.testData1)
        XCTAssertEqual(challenge.part1() as? Int, 2)
    }
    
    func testPart1_test_data2() throws {
        let challenge = Day08(data: self.testData2)
        XCTAssertEqual(challenge.part1() as? Int, 6)
    }
    
    func testPart2_test_data() {
        let challenge = Day08(data: self.testData3)
        XCTAssertEqual(challenge.part2() as? Int, 6)
    }
    
    func testPart2_real_data() {
        let challenge = Day08()
        print(challenge.part2())
    }
}
