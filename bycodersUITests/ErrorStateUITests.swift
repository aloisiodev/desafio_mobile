//
//  ErrorStateUITests.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import XCTest

final class ErrorStateUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--simulate-location-denied", "--skip-auth"]
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }
}
