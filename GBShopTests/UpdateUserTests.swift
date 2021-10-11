//
//  UpdateUserTests.swift
//  GBShopTests
//
//  Created by Karahanyan Levon on 03.09.2021.
//

import XCTest
@testable import GBShop

class UpdateUserTests: XCTestCase {
    let expectation = XCTestExpectation(description: "Update user")
    
    var requestFactory: RequestFactory!
    var updateUser: UpdateUserRequestFactory!

    override func setUp() {
        super.setUp()
        requestFactory = RequestFactory()
        updateUser = requestFactory.makeUpdateUserRequestFactory()
    }

    override func tearDown() {
        super.tearDown()
        requestFactory = nil
        updateUser = nil
    }

    func testShouldUpdateUser() throws {
        let updateUserData = UserData(id: 123,
                                            username: "Somebody",
                                            password: "mypassword",
                                            email: "some@some.ru",
                                            gender: Gender.male.rawValue,
                                            creditCard: "9872389-2424-234224-234",
                                            bio: "This is good! I think I will switch to another language")

        updateUser.updateUser(updateUserData: updateUserData) { response in
            switch response.result {
            case .success(_): break
            case .failure:
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }
}
