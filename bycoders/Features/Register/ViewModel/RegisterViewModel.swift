//
//  RegisterViewModel.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import Combine
import Foundation

@MainActor
final class RegisterViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let authService: AuthServicing
    
    init(authService: AuthServicing = FirebaseAuthService()) {
        self.authService = authService
    }
    
    func createUser() async -> AppUser? {
        guard validateFields() else { return nil }
        
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        do {
            return try await authService.createUser(
                email: email,
                password: password
            )
        } catch {
            errorMessage = error.localizedDescription
            CrashlyticsService.record(error)
            return nil
        }
    }
    
    private func validateFields() -> Bool {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Informe seu e-mail."
            return false
        }
        
        if password.isEmpty {
            errorMessage = "Informe sua senha."
            return false
        }
        
        if password.count < 6 {
            errorMessage = "A senha precisa ter pelo menos 6 caracteres."
            return false
        }
        
        if password != confirmPassword {
            errorMessage = "As senhas não conferem."
            return false
        }
        
        return true
    }
}
