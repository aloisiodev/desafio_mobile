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
            Color(hex: "#161616")
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 32) {
                Spacer()
                
                Image("bclogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Criar conta")
                        .font(.system(size: 32, weight: .light))
                        .foregroundStyle(.white)
                    
                    Text("Cadastre seu e-mail e senha.")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: "#C6C6C6"))
                }
                
                VStack(spacing: 12) {
                    TextField("E-mail", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding(.horizontal, 16)
                        .frame(height: 56)
                        .background(Color(hex: "#262626"))
                        .foregroundStyle(.white)
                    
                    SecureField("Senha", text: $viewModel.password)
                        .padding(.horizontal, 16)
                        .frame(height: 56)
                        .background(Color(hex: "#262626"))
                        .foregroundStyle(.white)
                    
                    SecureField("Confirmar senha", text: $viewModel.confirmPassword)
                        .padding(.horizontal, 16)
                        .frame(height: 56)
                        .background(Color(hex: "#262626"))
                        .foregroundStyle(.white)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
                
                Button {
                    Task {
                        if let user = await viewModel.createUser() {
                            path.removeLast(path.count)
                            sessionStore.setUser(user)
                        }
                    }
                } label: {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Criar conta")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .frame(height: 52)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#0F62FE"))
                }
                .disabled(viewModel.isLoading)
                
                Button {
                    dismiss()
                } label: {
                    Text("Já tenho uma conta")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: "#78A9FF"))
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
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
