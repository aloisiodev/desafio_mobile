//
//  AnalyticsService.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import FirebaseAnalytics

enum AnalyticsService {
    static func logLoginSuccess(userId: String) {
        Analytics.logEvent("login_success", parameters: [
            "user_id": userId
        ])
        print("[Analytics] login_success for user: \(userId)")
    }
    
    static func logMapRendered(userId: String) {
        Analytics.logEvent("map_rendered", parameters: [
            "user_id": userId
        ])
        print("[Analytics] map_rendered for user: \(userId)")
    }
}
