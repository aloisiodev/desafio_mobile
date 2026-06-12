//
//  SessionStore.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import Combine
import Foundation

protocol SessionStoring: AnyObject {
    var currentUser: AppUser? { get }
    var isAuthenticated: Bool { get }
    func setUser(_ user: AppUser)
    func clearUser()
    func signOut()
    func restoreSession()
}

class SessionStore: ObservableObject, SessionStoring {
    @Published private(set) var currentUser: AppUser?
    @Published private(set) var isAuthenticated: Bool = false

    private let authService: AuthServicing
    private let repository: LocalSessionRepositoring

    init(
        authService: AuthServicing = FirebaseAuthService(),
        repository: LocalSessionRepositoring = LocalSessionRepository.shared
    ) {
        self.authService = authService
        self.repository = repository
    }

    func restoreSession() {
        guard let user = authService.getCurrentUser() else {
            return
        }
        currentUser = user
        isAuthenticated = true
    }

    func setUser(_ user: AppUser) {
        currentUser = user
        isAuthenticated = true
        repository.save(user: user, coordinate: nil)
    }

    func clearUser() {
        currentUser = nil
        isAuthenticated = false
    }

    func signOut() {
        do {
            try authService.signOut()
            clearUser()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
