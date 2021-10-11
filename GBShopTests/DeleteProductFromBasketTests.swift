//
//  RemoveProductFromBasketTests.swift
//  GBShopTests
//
//  Created by Karahanyan Levon on 17.09.2021.
//

import XCTest
@testable import GBShop

class DeleteProductFromBasketTests: XCTestCase {
    let expectation = XCTestExpectation(description: "DeleteProductFromBasket")
    
    var requestFactory: RequestFactory!
    var deleteProductFromBasket: DeleteProductFromBasketRequestFactory!
    
    override func setUpWithError() throws {
        requestFactory = RequestFactory()
        deleteProductFromBasket = requestFactory.makeDeleteProductFromBasketRequestFactory()
    }
    
    override func tearDownWithError() throws {
        requestFactory = nil
        deleteProductFromBasket = nil
    }
    
    func testShouldGetAllReviews() throws {
        deleteProductFromBasket.deleteProductFromBasket(productId: 1) { response in
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
