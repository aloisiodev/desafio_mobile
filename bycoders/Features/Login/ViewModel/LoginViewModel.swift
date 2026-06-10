//
//  LoginViewModel.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import Combine
import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let authService: AuthServicing
    
    init(authService: AuthServicing = FirebaseAuthService()) {
        self.authService = authService
    }
    
    func signIn() async -> AppUser? {
        guard validateFields() else { return nil }
        
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        do {
            return try await authService.signIn(
                email: email,
                password: password
            )
        } catch {
            errorMessage = error.localizedDescription
            return nil
        }
    }
    
    private func validateFields() -> Bool {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Informe seu e-mail"
            return false
        }
        
        if password.isEmpty {
            errorMessage = "Informe sua senha"
            return false
        }
        
        return true
    }
}
