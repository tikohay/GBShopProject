//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Karahanyan Levon on 26.08.2021.
//

import XCTest

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
    }
    
    func testFail() {
        enterAuthData(login: "", password: "")
        app.buttons["Ok"].tap()
    }

    override func tearDownWithError() throws {
        
    }

    private func enterAuthData(login: String, password: String) {
        let textFieldStackView = scrollViewQuery.children(matching: .other).element(boundBy: 0)
        let buttonStackView = scrollViewQuery.otherElements
        
//        let loginTextField = textFieldStackView.children(matching: .other).element(boundBy: 0).children(matching: .textField).element
//        loginTextField.tap()
//        loginTextField.typeText(login)
//
//        let passwordTextField = textFieldStackView.children(matching: .other).element(boundBy: 1).children(matching: .secureTextField).element
//        passwordTextField.tap()
//        passwordTextField.typeText(password)
//
//        let loginButton =s buttonStackView.buttons["Log in"]
//        loginButton.tap()
        let loginTF = textFieldStackView.otherElements["loginTF"]
        loginTF.tap()
        
        
        let loginButton = buttonStackView.buttons["loginButton"]
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
