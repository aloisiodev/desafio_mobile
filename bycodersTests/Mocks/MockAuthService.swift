//
//  MockAuthService.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

@testable import bycoders
import Foundation

final class MockAuthService: AuthServicing {
    var shouldSucceed = true
    var mockUser = AppUser(id: "123", email: "test@test.com")
    var errorToThrow: Error = NSError(domain: "auth", code: 0, userInfo: [NSLocalizedDescriptionKey: "Auth error"])
    
    func signIn(email: String, password: String) async throws -> AppUser {
        if shouldSucceed { return mockUser }
        throw errorToThrow
    }

    func createUser(email: String, password: String) async throws -> AppUser {
        if shouldSucceed { return mockUser }
        throw errorToThrow
    }
    
    func signOut() throws {}

    func getCurrentUser() -> AppUser? {
        return shouldSucceed ? mockUser : nil
    }
}
