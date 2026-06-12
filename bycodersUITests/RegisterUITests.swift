//
//  RegisterUITests.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import XCTest

final class RegisterUITests: XCTestCase {

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

    private func navigateToRegister() {
        let createAccountButton = app.buttons["btn_create_account"]
        if createAccountButton.waitForExistence(timeout: 5) {
            createAccountButton.tap()
        }
    }

    func test_register_screenIsVisible() {
        navigateToRegister()
        let emailField = app.textFields["E-mail"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
    }

    func test_register_withEmptyFields_showsValidationError() {
        navigateToRegister()

        let registerButton = app.buttons["Criar conta"]
        XCTAssertTrue(registerButton.waitForExistence(timeout: 5))
        registerButton.tap()

        let errorText = app.staticTexts["Informe seu e-mail."]
        XCTAssertTrue(errorText.waitForExistence(timeout: 3))
    }

    func test_register_backToLogin_works() {
        navigateToRegister()

        let backButton = app.buttons["Já tenho uma conta"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        backButton.scrollToElement()
        backButton.tap()

        let loginButton = app.buttons["Entrar"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 5))
    }
}

extension XCUIElement {
    func scrollToElement(maxSwipes: Int = 5) {
        var attempts = 0
        while !isHittable && attempts < maxSwipes {
            XCUIApplication().swipeUp()
            attempts += 1
        }
    }
}
