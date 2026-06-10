//
//  AppDelegate.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import UIKit
import FirebaseCore

final class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        FirebaseManager.shared.configure()

        return true
    }
}
