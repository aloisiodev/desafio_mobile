//
//  MockSessionStore.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

@testable import bycoders

final class MockSessionStore: SessionStoring {
    var currentUser: AppUser?
    var isAuthenticated: Bool = false

    init() {
        setUser(AppUser(id: "123", email: "test@test.com"))
    }

    func setUser(_ user: AppUser) {
        currentUser = user
        isAuthenticated = true
    }

    func clearUser() {
        currentUser = nil
        isAuthenticated = false
    }

    func signOut() { clearUser() }
    func restoreSession() {}
}
