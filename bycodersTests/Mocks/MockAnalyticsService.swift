//
//  MockAnalyticsService.swift
//  bycoders
//
//  Created by Aloisio Mello on 11/06/26.
//

@testable import bycoders

final class MockAnalyticsService: AnalyticsServicing {
    private(set) var loggedLoginSuccess = false
    private(set) var loggedMapRendered = false
    private(set) var lastUserId: String?

    func logLoginSuccess(userId: String) {
        loggedLoginSuccess = true
        lastUserId = userId
    }

    func logMapRendered(userId: String) {
        loggedMapRendered = true
        lastUserId = userId
    }
}
