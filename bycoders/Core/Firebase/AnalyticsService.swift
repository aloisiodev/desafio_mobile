//
//  AnalyticsService.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import FirebaseAnalytics

protocol AnalyticsServicing {
    func logLoginSuccess(userId: String)
    func logMapRendered(userId: String)
}

final class AnalyticsService: AnalyticsServicing {
    init() {}

    func logLoginSuccess(userId: String) {
        Analytics.logEvent("login_success", parameters: ["user_id": userId])
    }

    func logMapRendered(userId: String) {
        Analytics.logEvent("map_rendered", parameters: ["user_id": userId])
    }
}
