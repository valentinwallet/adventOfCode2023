//
//  Day10Tests.swift
//
//
//  Created by Valentin Wallet on 09/12/2023.
//

import XCTest
@testable import AdventOfCode

final class Day10Tests: XCTestCase {
    let testData = """
    """
    
    func testPart1_test_data() throws {
        let challenge = Day10(data: self.testData)
        XCTAssertEqual(challenge.part1() as? Int, 114)
    }
}
