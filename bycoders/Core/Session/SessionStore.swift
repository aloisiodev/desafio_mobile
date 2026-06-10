//
//  SessionStore.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import Combine
import Foundation
import FirebaseAuth

class SessionStore: ObservableObject {
    @Published private(set) var currentUser: AppUser?
    @Published private(set) var isAuthenticated: Bool = false
    
    func restoreSession() {
        guard let firebaseUser = Auth.auth().currentUser else {
            print("User not authenticated")
            return
        }
        
        currentUser = AppUser(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? ""
        )
        
        isAuthenticated = true
        
        print("Session restored - ", firebaseUser.email ?? "")
    }
    
    func setUser(_ user: AppUser) {
        currentUser = user
        isAuthenticated = true
        LocalSessionRepository.shared.save(user: user, coordinate: nil)
    }
    
    func clearUser() {
        currentUser = nil
        isAuthenticated = false
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            clearUser()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
