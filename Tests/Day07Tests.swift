//
//  Day07Tests.swift
//  
//
//  Created by Valentin Wallet on 08/12/2023.
//

import XCTest
@testable import AdventOfCode

final class Day07Tests: XCTestCase {
    let testData1 = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """
    
    let testData2 = """
    424KT 464
    3J4QA 723
    94Q85 210
    25722 304
    Q4QQQ 176
    """
    
    let testData3 = """
    9T9KT 777
    T63J9 159
    6JJ36 898
    229T2 17
    J9QJ5 250
    """
    
    let testData4 = """
    5QT5J 86
    Q7QK6 713
    2JJ25 296
    8Q686 393
    QQ966 619
    JJTTT 537
    K9253 563
    59AQ3 702
    """
    
    let testData5 = """
    JJJJJ 90
    JJJJT 19
    JJJTT 90
    JJJTK 80
    JJTK9 09
    JJTT9 10
    JJTTT 12
    JTTTT 14
    JTK98 10
    JTK9T 90
    JTT9T 82
    """
    
    func testPart1_test_data() throws {
        let challenge = Day07(data: self.testData1)
        XCTAssertEqual(challenge.part1() as? Int, 6440)
    }
    
    func testPart1_test_real_data() throws {
        let challenge = Day07()
        print(challenge.part1())
    }
    
    func testPart2_test_data_1() throws {
        let challenge = Day07(data: self.testData1)
        XCTAssertEqual(challenge.part2() as? Int, 5905)
    }
    
    func testPart2_test_data_2() throws {
        let challenge = Day07(data: self.testData2)
        XCTAssertEqual(challenge.part2() as? Int, 5144)
    }
    
    func testPart2_test_data_3() throws {
        let challenge = Day07(data: self.testData3)
        XCTAssertEqual(challenge.part2() as? Int, 7021)
    }
    
    func testPart2_test_data_4() throws {
        let challenge = Day07(data: self.testData4)
        XCTAssertEqual(challenge.part2() as? Int, 15518)
    }
    
    func testPart2_test_data_5() throws {
        let challenge = Day07(data: self.testData5)
        XCTAssertEqual(challenge.part2() as? Int, 3026)
    }
    
    func testPart2_test_real_data() throws {
        let challenge = Day07()
        print(challenge.part2())
    }
}
