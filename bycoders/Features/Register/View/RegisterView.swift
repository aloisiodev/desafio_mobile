//
//  RegisterView.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import SwiftUI

struct RegisterView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var sessionStore: SessionStore
    @StateObject private var viewModel: RegisterViewModel
    @Binding var path: NavigationPath

    init(path: Binding<NavigationPath>) {
        self._path = path
        _viewModel = StateObject(
            wrappedValue: RegisterViewModel(
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
                    Text("Criar conta")
                        .font(Font.BC.pageTitle)
                        .foregroundStyle(Color.BC.textPrimary)

                    Text("Cadastre seu e-mail e senha.")
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

                    BCTextField(
                        placeholder: "Confirmar senha",
                        text: $viewModel.confirmPassword,
                        isSecure: true
                    )
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }

                BCPrimaryButton(label: "Criar conta", isLoading: viewModel.isLoading) {
                    Task {
                        if let user = await viewModel.createUser() {
                            path.removeLast(path.count)
                            sessionStore.setUser(user)
                        }
                    }
                }

                BCTextButton(label: "Já tenho uma conta") {
                    dismiss()
                }

                Spacer()
            }
            .padding(.horizontal, BCSpacing.xl)
        }
    }
}

#Preview {
    RegisterPreview()
}

private struct RegisterPreview: View {

    @State private var path = NavigationPath()

    var body: some View {
        RegisterView(path: $path)
            .environmentObject(SessionStore())
    }
}
