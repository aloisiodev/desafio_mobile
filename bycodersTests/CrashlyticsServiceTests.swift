//
//  CrashlyticsServiceTests.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import Testing
import Foundation
@testable import bycoders

@MainActor
struct CrashlyticsServiceTests {

    @Test func signIn_failure_recordsError() async {
        let crashlytics = MockCrashlyticsService()
        let mock = MockAuthService()
        mock.shouldSucceed = false
        let viewModel = LoginViewModel(
            authService: mock,
            analytics: MockAnalyticsService(),
            crashlytics: crashlytics
        )
        viewModel.email = "test@test.com"
        viewModel.password = "123456"

        await viewModel.signIn()

        #expect(crashlytics.recordedErrors.count == 1)
    }

    @Test func createUser_failure_recordsError() async {
        let crashlytics = MockCrashlyticsService()
        let mock = MockAuthService()
        mock.shouldSucceed = false
        let viewModel = RegisterViewModel(
            authService: mock,
            crashlytics: crashlytics
        )
        viewModel.email = "test@test.com"
        viewModel.password = "123456"
        viewModel.confirmPassword = "123456"

        await viewModel.createUser()

        #expect(crashlytics.recordedErrors.count == 1)
    }
}
