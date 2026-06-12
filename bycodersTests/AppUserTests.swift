//
//  AppUserTests.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import Testing
@testable import bycoders

struct AppUserTests {

    @Test func equatable_withSameValues_isEqual() {
        let user1 = AppUser(id: "1", email: "a@a.com")
        let user2 = AppUser(id: "1", email: "a@a.com")
        #expect(user1 == user2)
    }

    @Test func equatable_withDifferentId_isNotEqual() {
        let user1 = AppUser(id: "1", email: "a@a.com")
        let user2 = AppUser(id: "2", email: "a@a.com")
        #expect(user1 != user2)
    }

    @Test func identifiable_usesIdProperty() {
        let user = AppUser(id: "abc123", email: "a@a.com")
        #expect(user.id == "abc123")
    }
}
