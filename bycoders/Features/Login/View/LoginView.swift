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
            Color(hex: "#161616")
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 32) {
                Spacer()
                
                Image("bclogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Login")
                        .font(.system(size: 32, weight: .light))
                        .foregroundStyle(.white)
                    
                    Text("Entre com seu e-mail e senha.")
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
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
                
                Button {
                    Task {
                        if let user = await viewModel.signIn() {
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
                            Text("Entrar")
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
                
                VStack(alignment: .leading, spacing: 12) {
                    Rectangle()
                        .fill(Color(hex: "#393939"))
                        .frame(height: 1)
                    
                    Button {
                        path.append(AppRoute.register)
                    } label: {
                        HStack {
                            Text("Não possui uma conta?")
                                .foregroundStyle(Color(hex: "#C6C6C6"))
                            
                            Text("Criar conta")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(hex: "#78A9FF"))
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                                .foregroundStyle(Color(hex: "#78A9FF"))
                        }
                        .font(.system(size: 14))
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
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
                    case .register:
                        Text("RegisterView")
                    case .home:
                        Text("HomeView")
                    case .login:
                        Text("LoginView")
                    }
                }
        }
    }
}
