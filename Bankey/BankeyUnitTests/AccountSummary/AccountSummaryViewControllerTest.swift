//
//  AccountSummaryViewControllerTest.swift
//  BankeyUnitTests
//
//  Created by Alejandro Cervantes on 2024-04-09.
//

import Foundation
import XCTest

@testable import Bankey

class AccountSummaryViewControllerTests: XCTestCase {
    
    var accountManagerVC: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    class MockProfileManager: ProfileManageable {
        var profile: Profile?
        var error: NetworkError?
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
    }
    
    override func setUp() {
        super.setUp()
        accountManagerVC = AccountSummaryViewController()
        // vc.loadViewIfNeeded()
        mockManager = MockProfileManager()
        accountManagerVC.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = accountManagerVC.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.1)
    }
    
    func testTitleAndMessageForDecodingError() throws {
        let titleAndMessage = accountManagerVC.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Decoding Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. Please try again.", titleAndMessage.1)
    }
    
    func testAlertForServerError() throws {
        mockManager.error = NetworkError.serverError
        accountManagerVC.forceFetchProfile()
        
        XCTAssertEqual("Server Error", accountManagerVC.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", accountManagerVC.errorAlert.message)
    }
    
    func testAlertForDecodingError() throws {
        mockManager.error = NetworkError.decodingError
        accountManagerVC.forceFetchProfile()
        
        XCTAssertEqual("Decoding Error", accountManagerVC.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", accountManagerVC.errorAlert.message)
    }
}
