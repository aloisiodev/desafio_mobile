//
//  LoginUITests.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import XCTest

final class LoginUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--uitesting", "--reset-session"]
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func test_login_withValidCredentials_navigatesToHome() {
        let emailField = app.textFields["E-mail"]
        let passwordField = app.secureTextFields["Senha"]
        let loginButton = app.buttons["Entrar"]

        XCTAssertTrue(emailField.waitForExistence(timeout: 5))

        emailField.tap()
        emailField.typeText("teste@teste.com")

        passwordField.tap()
        passwordField.typeText("123456")

        loginButton.tap()

        let logoutButton = app.buttons["btn_logout"]
        XCTAssertTrue(logoutButton.waitForExistence(timeout: 10))
    }

    func test_login_withInvalidCredentials_showsError() {
        let emailField = app.textFields["E-mail"]
        let passwordField = app.secureTextFields["Senha"]
        let loginButton = app.buttons["Entrar"]

        XCTAssertTrue(emailField.waitForExistence(timeout: 5))

        emailField.tap()
        emailField.typeText("invalido@teste.com")

        passwordField.tap()
        passwordField.typeText("senhaerrada")

        loginButton.tap()

        let errorText = app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'senha'")).firstMatch
        XCTAssertTrue(errorText.waitForExistence(timeout: 5))
    }

    func test_login_withEmptyFields_showsValidationError() {
        let loginButton = app.buttons["Entrar"]

        XCTAssertTrue(loginButton.waitForExistence(timeout: 5))
        loginButton.tap()

        let errorText = app.staticTexts["Informe seu e-mail"]
        XCTAssertTrue(errorText.waitForExistence(timeout: 3))
    }
}
