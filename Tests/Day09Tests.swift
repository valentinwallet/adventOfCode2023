//
//  Day09Tests.swift
//
//
//  Created by Valentin Wallet on 09/12/2023.
//

import XCTest
@testable import AdventOfCode

final class Day09Tests: XCTestCase {
    let testData = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """
    
    func testPart1_test_data() throws {
        let challenge = Day09(data: self.testData)
        XCTAssertEqual(challenge.part1() as? Int, 114)
    }
    
    func testPart1_test_real_data() throws {
        let challenge = Day09()
        print(challenge.part1())
    }
    
    func testPart2_test_data() throws {
        let challenge = Day09(data: self.testData)
        XCTAssertEqual(challenge.part2() as? Int, 2)
    }
    
    func testPart2_real_data() throws {
        let challenge = Day09()
        print(challenge.part2())
    }
}
