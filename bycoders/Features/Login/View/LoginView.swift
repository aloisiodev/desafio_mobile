//
//  LoginView.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import SwiftUI

struct LoginView: View {

    @EnvironmentObject private var sessionStore: SessionStore
    @StateObject private var viewModel: LoginViewModel
    @Binding var path: NavigationPath

    init(path: Binding<NavigationPath>) {
        self._path = path
        self._viewModel = StateObject(
            wrappedValue: LoginViewModel(
                authService: FirebaseAuthService()
            )
        )
    }

    var body: some View {
        ZStack {
            Color.BC.background.ignoresSafeArea()

            VStack(alignment: .leading, spacing: BCSpacing.xxl) {
                Spacer()

                Image("bclogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: BCSpacing.Component.logo)

                VStack(alignment: .leading, spacing: BCSpacing.sm) {
                    Text("Login")
                        .font(Font.BC.pageTitle)
                        .foregroundStyle(Color.BC.textPrimary)

                    Text("Entre com seu e-mail e senha.")
                        .font(Font.BC.body)
                        .foregroundStyle(Color.BC.textSecondary)
                }

                VStack(spacing: BCSpacing.md) {
                    BCTextField(
                        placeholder: "E-mail",
                        text: $viewModel.email,
                        keyboardType: .emailAddress,
                        autocapitalization: .never
                    )

                    BCTextField(
                        placeholder: "Senha",
                        text: $viewModel.password,
                        isSecure: true
                    )
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }

                BCPrimaryButton(label: "Entrar", isLoading: viewModel.isLoading) {
                    Task {
                        if let user = await viewModel.signIn() {
                            path.removeLast(path.count)
                            sessionStore.setUser(user)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: BCSpacing.md) {
                    Rectangle()
                        .fill(Color.BC.divider)
                        .frame(height: 1)

                    BCLinkButton(
                        leadingText: "Não possui uma conta?",
                        trailingText: "Criar conta"
                    ) {
                        path.append(AppRoute.register)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, BCSpacing.xl)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginPreview()
}

private struct LoginPreview: View {

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            LoginView(path: $path)
                .environmentObject(SessionStore())
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .register: Text("RegisterView")
                    case .home:     Text("HomeView")
                    case .login:    Text("LoginView")
                    }
                }
        }
    }
}
