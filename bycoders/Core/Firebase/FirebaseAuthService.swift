//
//  FirebaseAuthService.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import Foundation
import FirebaseAuth

protocol AuthServicing {
    func signIn(email: String, password: String) async throws -> AppUser
    func createUser(email: String, password: String) async throws -> AppUser
    func signOut() throws
    func getCurrentUser() -> AppUser?
}

final class FirebaseAuthService: AuthServicing {
    func signIn(email: String, password: String) async throws -> AppUser {
        let result = try await Auth.auth().signIn(
            withEmail: email,
            password: password)
        
        let firebaseUser = result.user
        
        return AppUser(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? ""
        )
    }
    
    func createUser(email: String, password: String) async throws -> AppUser {
        let result = try await Auth.auth().createUser(
            withEmail: email,
            password: password
        )
        
        let user = result.user
        
        return AppUser(
            id: user.uid,
            email: user.email ?? ""
        )
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func getCurrentUser() -> AppUser? {
        guard let firebaseUser = Auth.auth().currentUser else {
            return nil
        }
        
        return AppUser(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? ""
        )
    }
}
