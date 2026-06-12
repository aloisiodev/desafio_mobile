//
//  RegisterViewModelTests.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import Testing
@testable import bycoders

@MainActor
struct RegisterViewModelTests {

    @Test func createUser_withValidCredentials_returnsUser() async {
        let mock = MockAuthService()
        let viewModel = RegisterViewModel(authService: mock)

        viewModel.email = "test@test.com"
        viewModel.password = "123456"
        viewModel.confirmPassword = "123456"

        let user = await viewModel.createUser()

        #expect(user != nil)
        #expect(user?.email == "test@test.com")
    }

    @Test func createUser_withEmptyEmail_returnsNil() async {
        let mock = MockAuthService()
        let viewModel = RegisterViewModel(authService: mock)

        viewModel.email = ""
        viewModel.password = "123456"
        viewModel.confirmPassword = "123456"

        let user = await viewModel.createUser()

        #expect(user == nil)
        #expect(viewModel.errorMessage == "Informe seu e-mail.")
    }

    @Test func createUser_withShortPassword_returnsNil() async {
        let mock = MockAuthService()
        let viewModel = RegisterViewModel(authService: mock)

        viewModel.email = "test@test.com"
        viewModel.password = "123"
        viewModel.confirmPassword = "123"

        let user = await viewModel.createUser()

        #expect(user == nil)
        #expect(viewModel.errorMessage == "A senha precisa ter pelo menos 6 caracteres.")
    }

    @Test func createUser_withPasswordMismatch_returnsNil() async {
        let mock = MockAuthService()
        let viewModel = RegisterViewModel(authService: mock)

        viewModel.email = "test@test.com"
        viewModel.password = "123456"
        viewModel.confirmPassword = "654321"

        let user = await viewModel.createUser()

        #expect(user == nil)
        #expect(viewModel.errorMessage == "As senhas não conferem.")
    }

    @Test func createUser_withAuthError_setsErrorMessage() async {
        let mock = MockAuthService()
        mock.shouldSucceed = false
        let viewModel = RegisterViewModel(authService: mock)

        viewModel.email = "test@test.com"
        viewModel.password = "123456"
        viewModel.confirmPassword = "123456"

        let user = await viewModel.createUser()

        #expect(user == nil)
        #expect(viewModel.errorMessage != nil)
    }
}
