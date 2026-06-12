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
    private let analytics: AnalyticsServicing
    private let crashlytics: CrashlyticsServicing

    init(
        authService: AuthServicing = FirebaseAuthService(),
        analytics: AnalyticsServicing = AnalyticsService(),
        crashlytics: CrashlyticsServicing = CrashlyticsService()
    ) {
        self.authService = authService
        self.analytics = analytics
        self.crashlytics = crashlytics
    }

    func signIn() async -> AppUser? {
        guard validateFields() else { return nil }

        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            let user = try await authService.signIn(
                email: email,
                password: password
            )

            analytics.logLoginSuccess(userId: user.id)
            return user
        } catch {
            errorMessage = error.localizedDescription
            crashlytics.record(error)
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
