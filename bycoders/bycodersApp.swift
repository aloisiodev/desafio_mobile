//
//  bycodersApp.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import CoreData
import SwiftUI

@main
struct bycodersApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    let persistenceController = PersistenceController.shared
    
    @StateObject private var sessionStore = SessionStore()
    @State private var path = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                rootView
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .login:
                            LoginView(path: $path)
                        case .register:
                            RegisterView(path: $path)
                        case .home:
                            HomeView(path: $path, sessionStore: sessionStore)
                        }
                    }
            }
            .task {
                if !ProcessInfo.processInfo.arguments.contains("--reset-session") {
                    sessionStore.restoreSession()
                }
            }
            .environmentObject(sessionStore)
            .environment(
                \.managedObjectContext,
                persistenceController.container.viewContext
            )
        }
    }
    
    @ViewBuilder
    private var rootView: some View {
        if sessionStore.isAuthenticated {
            HomeView(path: $path, sessionStore: sessionStore)
        } else {
            LoginView(path: $path)
        }
    }
}
