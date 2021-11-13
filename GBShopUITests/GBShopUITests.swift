//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Karahanyan Levon on 26.08.2021.
//

import XCTest
import GBShop

class GBShopUITests: XCTestCase {
    var app: XCUIApplication!
    var scrollViewQuery: XCUIElementQuery!
    
    func testExample() {
    
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        scrollViewQuery = app.scrollViews
    }
    
    func testSuccess() {
        enterAuthData(login: "admin", password: "1234567")
        XCTAssertFalse(app.otherElements.staticTexts["Login or password is wrong"].waitForExistence(timeout: 5.0))
    }

    func testFail() {
        enterAuthData(login: "", password: "")
        XCTAssertTrue(app.otherElements.staticTexts["Login or password is wrong"].waitForExistence(timeout: 5.0))
    }

    override func tearDownWithError() throws {
        app = nil
        scrollViewQuery = nil
    }

    private func enterAuthData(login: String, password: String) {
        let loginTF = scrollViewQuery.textFields["loginTF"].firstMatch
        loginTF.tap()
        loginTF.typeText(login)
        
        let passwordTF = scrollViewQuery.secureTextFields["passwordTF"].firstMatch
        passwordTF.tap()
        passwordTF.typeText(password)
        
        let loginButton = scrollViewQuery.buttons["loginButton"].firstMatch
        loginButton.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
