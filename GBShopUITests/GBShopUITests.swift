//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Karahanyan Levon on 26.08.2021.
//

import XCTest
import GBShop
@testable import GBShop

class GBShopUITests: XCTestCase {
    
    var app: XCUIApplication!
    var scrollViewQuery: XCUIElementQuery!
    
    func testExample() {
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        let textfieldTextField = elementsQuery.textFields["textfield"]
        textfieldTextField.tap()
        elementsQuery.secureTextFields["textfield"].tap()
        textfieldTextField.tap()
        elementsQuery.buttons["Log in"].tap()
        app.buttons["Ok"].tap()
        
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        scrollViewQuery = app.scrollViews
    }
    
    func testSuccess() {
        enterAuthData(login: "admin", password: "1234567")
    }
    
    func testFail() {
        enterAuthData(login: "", password: "")
        app.buttons["Ok"].tap()
    }

    override func tearDownWithError() throws {
        app = nil
        scrollViewQuery = nil
    }

    private func enterAuthData(login: String, password: String) {
        let textFieldStackView = scrollViewQuery.children(matching: .other).element(boundBy: 0)
//        let buttonStackView = scrollViewQuery.otherElements
//
//        let loginTextField = textFieldStackView.children(matching: .other).element(boundBy: 0).children(matching: .textField).element
//        loginTextField.tap()
//        loginTextField.typeText(login)
//
//        let passwordTextField = textFieldStackView.children(matching: .other).element(boundBy: 1).children(matching: .secureTextField).element
//        passwordTextField.tap()
//        passwordTextField.typeText(password)
//
//        let loginButton = buttonStackView.buttons["Log in"]
//        loginButton.tap()
//        let id = GBShopStandardTextField.tfAccessibilityIdentifier
        
        let loginTF = scrollViewQuery.textFields["loginTF"].firstMatch
        loginTF.tap()
        loginTF.typeText("hello")
        
        let passwordTF = scrollViewQuery.secureTextFields["passwordTF"].firstMatch
        passwordTF.tap()
        passwordTF.typeText("world")
        
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
