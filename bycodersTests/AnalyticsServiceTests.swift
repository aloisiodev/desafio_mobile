//
//  AnalyticsServiceTests.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import Testing
@testable import bycoders

@MainActor
struct AnalyticsServiceTests {

    @Test func signIn_success_logsLoginSuccess() async {
        let analytics = MockAnalyticsService()
        let viewModel = LoginViewModel(
            authService: MockAuthService(),
            analytics: analytics,
            crashlytics: MockCrashlyticsService()
        )
        viewModel.email = "test@test.com"
        viewModel.password = "123456"

        await viewModel.signIn()

        #expect(analytics.loggedLoginSuccess == true)
        #expect(analytics.lastUserId == "123")
    }

    @Test func signIn_failure_doesNotLogLoginSuccess() async {
        let analytics = MockAnalyticsService()
        let mock = MockAuthService()
        mock.shouldSucceed = false
        let viewModel = LoginViewModel(
            authService: mock,
            analytics: analytics,
            crashlytics: MockCrashlyticsService()
        )
        viewModel.email = "test@test.com"
        viewModel.password = "123456"

        await viewModel.signIn()

        #expect(analytics.loggedLoginSuccess == false)
    }
}
