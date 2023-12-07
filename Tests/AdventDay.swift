import XCTest

@testable import AdventOfCode

final class AdventDayTests: XCTestCase {
    func testInitData() throws {
        let challenge = Day04()
        XCTAssertTrue(challenge.data.starts(with: "Card   1:"))
    }
}
