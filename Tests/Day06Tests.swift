//
//  Day06Tests.swift
//  
//
//  Created by Valentin Wallet on 07/12/2023.
//

@testable import AdventOfCode
import XCTest

final class Day06Tests: XCTestCase {
    let testData = """
    Time:      7  15   30
    Distance:  9  40  200
    """
    
    func testPart1_test_data() throws {
        let challenge = Day06(data: self.testData)
        XCTAssertEqual(challenge.part1() as? Int, 288)
    }
    
    func testPart1_real_data() throws {
        let challenge = Day06()
        print(challenge.part1())
    }
    
    func testPart2_test_data() throws {
        let challenge = Day06(data: self.testData)
        XCTAssertEqual(challenge.part2() as? Int, 71503)
    }
    
    func testPart2_real_data() throws {
        let challenge = Day06()
        print(challenge.part2())
    }
}
