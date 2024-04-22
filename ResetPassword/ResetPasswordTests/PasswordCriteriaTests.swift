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

    func testLengthAndNoSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceMet("12345678"))
    }

    func testLengthAndNoSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceMet("1234567 8"))
    }
    
    func testUpperCaseMet() throws {
        XCTAssertTrue(PasswordCriteria.uppercaseMet("A"))
    }

    func testUpperCaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.uppercaseMet("a"))
    }

    func testLowerCaseMet() throws {
        XCTAssertTrue(PasswordCriteria.lowercaseMet("a"))
    }

    func testLowerCaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lowercaseMet("A"))
    }

    func testDigitMet() throws {
        XCTAssertTrue(PasswordCriteria.digitcaseMet("1"))
    }

    func testDigitNotMet() throws {
        XCTAssertFalse(PasswordCriteria.digitcaseMet("a"))
    }
    
    func testSpecicalCharMet() throws {
        XCTAssertTrue(PasswordCriteria.specialcharMet("@"))
    }

    func testSpecicalCharNotMet() throws {
        XCTAssertFalse(PasswordCriteria.specialcharMet("a"))
    }
}
