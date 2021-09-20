//
//  AddProductToBasketTests.swift
//  GBShopTests
//
//  Created by Karahanyan Levon on 17.09.2021.
//

import XCTest
@testable import GBShop

class AddProductToBasketTests: XCTestCase {
    let expectation = XCTestExpectation(description: "AddProductToBasket")
    
    var requestFactory: RequestFactory!
    var addProductToBasket: AddProductToBasketRequestFactory!
    
    override func setUpWithError() throws {
        requestFactory = RequestFactory()
        addProductToBasket = requestFactory.makeAddProductToBasketRequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
        addProductToBasket = nil
    }

    func testShouldAddProductToBasket() throws {
        addProductToBasket.addProductToBasket(productId: 123, quantity: 1) { response in
            switch response.result {
            case .success(_): break
            case .failure:
                XCTFail()
            }
            self.expectation.fulfill()
        }
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
