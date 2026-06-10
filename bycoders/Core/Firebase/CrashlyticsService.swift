//
//  CrashlyticsService.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import FirebaseCrashlytics

enum CrashlyticsService {
    static func record(_ error: Error) {
        Crashlytics.crashlytics().record(error: error)
        print("[Crashlytics] Recording error: \(error.localizedDescription)")
    }
    
    static func record(message: String) {
        Crashlytics.crashlytics().log(message)
        print("[Crashlytics] Recording error: \(message)")
    }
}
