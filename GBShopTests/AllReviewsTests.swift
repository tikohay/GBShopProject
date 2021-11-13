//
//  AllReviewsTests.swift
//  GBShopTests
//
//  Created by Karahanyan Levon on 14.09.2021.
//

import XCTest
@testable import GBShop

class AllReviewsTests: XCTestCase {
    let expectation = XCTestExpectation(description: "AllReviews")
    
    var requestFactory: RequestFactory!
    var allReviews: AllReviewsRequestFactory!
    
    override func setUpWithError() throws {
        requestFactory = RequestFactory()
        allReviews = requestFactory.makeAllReviewsRequestFactory()
    }
    
    override func tearDownWithError() throws {
        requestFactory = nil
        allReviews = nil
    }
    
    func testShouldGetAllReviews() throws {
        allReviews.getAllReviews(productId: 1) { response in
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
