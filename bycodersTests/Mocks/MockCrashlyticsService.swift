//
//  MockCrashlyticsService.swift
//  bycoders
//
//  Created by Aloisio Mello on 11/06/26.
//

@testable import bycoders

final class MockCrashlyticsService: CrashlyticsServicing {
    private(set) var recordedErrors: [Error] = []
    private(set) var recordedMessages: [String] = []

    func record(_ error: Error) {
        recordedErrors.append(error)
    }

    func record(message: String) {
        recordedMessages.append(message)
    }
}
