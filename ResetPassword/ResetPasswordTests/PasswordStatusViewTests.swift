//
//  PasswordStatusViewTests.swift
//  ResetPasswordTests
//
//  Created by Alejandro Cervantes on 2024-04-21.
//

import XCTest

@testable import ResetPassword

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true // inline
    }

    /*
     if shouldResetCriteria {
         // Inline validation (✅ or ⚪️)
     } else {
         ...
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage) // ✅
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage) // ⚪️
    }
}

class PasswordStatusViewTests_ShowCheckmarkOrRedX_When_Validation_Is_Loss_Of_Focus: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"

    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false // loss of focus
    }

    /*
     if shouldResetCriteria {
         ...
     } else {
         // Focus lost (✅ or ❌)
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertFalse(statusView.lengthCriteriaView.isXMarkImage)
    }

    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXMarkImage)
        XCTAssertFalse(statusView.lengthCriteriaView.isCheckMarkImage)
    }
}

class PasswordStatusViewTests_Validate_Criteria: XCTestCase {

    var statusView: PasswordStatusView!
    let twoOfFour = "12345678A"
    let threeOfFour = "12345678Aa"
    let fourOfFour = "12345678Aa!"
    let tooShort = "Aa"

    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }

    func testTwoOfFour() throws {
        XCTAssertFalse(statusView.validate(twoOfFour))
    }

    func testThreeOfFour() throws {
        XCTAssertTrue(statusView.validate(threeOfFour))
    }
    
    func testFourOfFour() throws {
        XCTAssertTrue(statusView.validate(fourOfFour))
    }
    
    func testTooShort() throws {
        XCTAssertFalse(statusView.validate(tooShort))
    }
}
