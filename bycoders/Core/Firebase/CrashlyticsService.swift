//
//  CrashlyticsService.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import FirebaseCrashlytics

protocol CrashlyticsServicing {
    func record(_ error: Error)
    func record(message: String)
}

final class CrashlyticsService: CrashlyticsServicing {
    init() {}

    func record(_ error: Error) {
        Crashlytics.crashlytics().record(error: error)
    }

    func record(message: String) {
        Crashlytics.crashlytics().log(message)
    }
}
