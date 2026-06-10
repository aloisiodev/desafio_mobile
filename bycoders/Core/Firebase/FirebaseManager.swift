//
//  FirebaseManager.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import FirebaseCore

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private init() {}
    
    func configure() {
        guard FirebaseApp.app() == nil else {
            return
        }
        
        FirebaseApp.configure()
        
        #if DEBUG
        print("Firebase configured successfully")
        #endif
    }
}
