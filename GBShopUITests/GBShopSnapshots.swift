//
//  GBShopSnapshots.swift
//  GBShopUITests
//
//  Created by Karahanyan Levon on 30.10.2021.
//

import XCTest

class GBShopSnapshots: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        
    }
    
    func testShouldMakeSnapshot() {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        snapshot("LoginViewController")
    }
}
