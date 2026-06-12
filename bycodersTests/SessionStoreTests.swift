//
//  SessionStoreTests.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import Testing
@testable import bycoders

@MainActor
struct SessionStoreTests {

    @Test func setUser_setsCurrentUserAndAuthenticated() {
        let store = SessionStore(authService: MockAuthService(), repository: MockLocalSessionRepository())
        let user = AppUser(id: "1", email: "a@a.com")

        store.setUser(user)

        #expect(store.currentUser == user)
        #expect(store.isAuthenticated == true)
    }

    @Test func clearUser_removesCurrentUserAndAuthenticated() {
        let store = SessionStore(authService: MockAuthService(), repository: MockLocalSessionRepository())
        store.setUser(AppUser(id: "1", email: "a@a.com"))

        store.clearUser()

        #expect(store.currentUser == nil)
        #expect(store.isAuthenticated == false)
    }

    @Test func signOut_success_clearsUser() {
        let mockAuth = MockAuthService()
        mockAuth.shouldSucceed = true
        let store = SessionStore(authService: mockAuth, repository: MockLocalSessionRepository())
        store.setUser(AppUser(id: "1", email: "a@a.com"))

        store.signOut()

        #expect(store.currentUser == nil)
        #expect(store.isAuthenticated == false)
    }

    @Test func restoreSession_withAuthenticatedUser_setsUser() {
        let mockAuth = MockAuthService()
        mockAuth.shouldSucceed = true
        let store = SessionStore(authService: mockAuth, repository: MockLocalSessionRepository())

        store.restoreSession()

        #expect(store.currentUser != nil)
        #expect(store.isAuthenticated == true)
    }

    @Test func restoreSession_withNoUser_doesNotSetUser() {
        let mockAuth = MockAuthService()
        mockAuth.shouldSucceed = false
        let store = SessionStore(authService: mockAuth, repository: MockLocalSessionRepository())

        store.restoreSession()

        #expect(store.currentUser == nil)
        #expect(store.isAuthenticated == false)
    }
}
