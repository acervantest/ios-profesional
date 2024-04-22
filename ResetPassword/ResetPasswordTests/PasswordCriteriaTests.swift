//
//  PasswordCriteriaTests.swift
//  ResetPasswordTests
//
//  Created by Alejandro Cervantes on 2024-04-20.
//

import XCTest

@testable import ResetPassword

class PasswordLengthCriteriaTests: XCTestCase {
    
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }

    func testLong() throws {
        let thirtyThreeLong = "123456789012345678901234567890123"
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet(thirtyThreeLong))
    }
    
    func testValidShort() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
    }

    func testValidLong() throws {
        let thirtyTwoLong = "12345678901234567890123456789012"
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet(thirtyTwoLong))
    }
}

class PasswordOtherCriteriaTests: XCTestCase {
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bc"))
    }
}
