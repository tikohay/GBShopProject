//
//  PayBasketTests.swift
//  GBShopTests
//
//  Created by Karahanyan Levon on 22.09.2021.
//

import XCTest
@testable import GBShop

class PayBasketTests: XCTestCase {
    let expectation = XCTestExpectation(description: "PayBasket")
    
    var requestFactory: RequestFactory!
    var payBasket: PayBasketRequestFactory!
    
    override func setUpWithError() throws {
        requestFactory = RequestFactory()
        payBasket = requestFactory.makePayBasketRequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
        payBasket = nil
    }
    
    func testShouldPayBasket() throws {
        payBasket.payBasket(userId: 1) { response in
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
