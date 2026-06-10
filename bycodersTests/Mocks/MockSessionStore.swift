//
//  MockSessionStore.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

@testable import bycoders

final class MockSessionStore: SessionStore {
    override init() {
        super.init()
        setUser(AppUser(id: "123", email: "test@test.com"))
    }
}
