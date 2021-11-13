//
//  ProductTests.swift
//  GBShopTests
//
//  Created by Karahanyan Levon on 03.09.2021.
//

import XCTest
@testable import GBShop

class ProductTests: XCTestCase {
    let expectation = XCTestExpectation(description: "Product")
    
    var requestFactory: RequestFactory!
    var product: ProductRequestFactory!

    override func setUp() {
        super.setUp()
        requestFactory = RequestFactory()
        product = requestFactory.makeProductRequestFactory()
    }

    override func tearDown() {
        super.tearDown()
        requestFactory = nil
        product = nil
    }

    func testShouldGetCatalog() throws {
        product.getProduct(productId: 1) { response in
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
