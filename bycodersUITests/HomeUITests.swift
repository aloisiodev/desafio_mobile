//
//  HomeUITests.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import XCTest

final class HomeUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    private func loginIfNeeded() {
        let emailField = app.textFields["E-mail"]
        guard emailField.waitForExistence(timeout: 3) else { return }

        emailField.tap()
        emailField.typeText("teste@teste.com")

        app.secureTextFields["Senha"].tap()
        app.secureTextFields["Senha"].typeText("123456")

        app.buttons["Entrar"].tap()
    }

    func test_home_showsHeaderAfterLogin() {
        loginIfNeeded()

        let logoutButton = app.buttons["btn_logout"]
        XCTAssertTrue(logoutButton.waitForExistence(timeout: 10))
    }

    func test_home_showsUserEmail() {
        loginIfNeeded()

        let emailText = app.staticTexts["teste@teste.com"]
        XCTAssertTrue(emailText.waitForExistence(timeout: 10))
    }

    func test_home_logoutReturnsToLogin() {
        loginIfNeeded()

        let logoutButton = app.buttons["btn_logout"]
        XCTAssertTrue(logoutButton.waitForExistence(timeout: 10))
        logoutButton.tap()

        let emailField = app.textFields["E-mail"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
    }
}
