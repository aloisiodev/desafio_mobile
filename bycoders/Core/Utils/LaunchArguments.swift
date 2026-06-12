//
//  LaunchArguments.swift
//  bycoders
//
//  Created by Aloisio Mello on 11/06/26.
//

import Foundation

enum LaunchArguments {
    #if DEBUG
    static var skipAuth: Bool {
        ProcessInfo.processInfo.arguments.contains("--skip-auth")
    }

    static var resetSession: Bool {
        ProcessInfo.processInfo.arguments.contains("--reset-session")
    }

    static var simulateLocationDenied: Bool {
        ProcessInfo.processInfo.arguments.contains("--simulate-location-denied")
    }
    #else
    static let skipAuth = false
    static let resetSession = false
    static let simulateLocationDenied = false
    #endif
}
