//
//  SignUpUITests.swift
//  GBShopUITests
//
//  Created by Karahanyan Levon on 13.10.2021.
//

import XCTest
import GBShop

class SignUpUITests: XCTestCase {
    var app: XCUIApplication!
    var scrollViewQuery: XCUIElementQuery!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
        scrollViewQuery = app.scrollViews
    }

    override func tearDownWithError() throws {
        app = nil
        scrollViewQuery = nil
    }

    func testExample() throws {
              
    }
    
    func testSuccess() {
        enterSignUpData(username: "A",
                        password: "a",
                        email: "a",
                        creditCard: "a",
                        bio: "a")
        XCTAssertFalse(app.otherElements.staticTexts["The parameters are entered incorrectly"].waitForExistence(timeout: 5.0))
    }

    func testFailure() {
        enterSignUpData(username: "",
                        password: "a",
                        email: "a",
                        creditCard: "a",
                        bio: "a")
        XCTAssertTrue(app.otherElements.staticTexts["The parameters are entered incorrectly"].waitForExistence(timeout: 5.0))
    }
    
    private func enterSignUpData(username: String,
                                 password: String,
                                 email: String,
                                 creditCard: String,
                                 bio: String) {
        let signUpButton = scrollViewQuery.buttons["registrationButton"].firstMatch
        signUpButton.tap()

        let usernameTextField = scrollViewQuery.textFields["usernameTextField"].firstMatch
        usernameTextField.tap()
        usernameTextField.typeText(username)

        let emailTextField = scrollViewQuery.textFields["emailTextField"].firstMatch
        emailTextField.tap()
        emailTextField.typeText(email)

        let passwordTextField = scrollViewQuery.secureTextFields["passwordTextField"].firstMatch
        passwordTextField.tap()
        passwordTextField.typeText(password)

        let creditCardTextField = scrollViewQuery.textFields["creditCardTextField"].firstMatch
        creditCardTextField.tap()
        creditCardTextField.typeText(creditCard)

        let bioTextField = scrollViewQuery.textFields["bioTextField"].firstMatch
        bioTextField.tap()
        bioTextField.typeText(bio)
        
        let submitButton = scrollViewQuery.buttons["submitButton"].firstMatch
        submitButton.tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}






















