import Testing
@testable import bycoders

@MainActor
struct LoginViewModelTests {

    @Test func signIn_withValidCredentials_returnsUser() async {
        let mock = MockAuthService()
        let viewModel = LoginViewModel(authService: mock)

        viewModel.email = "test@test.com"
        viewModel.password = "123456"

        let user = await viewModel.signIn()

        #expect(user != nil)
        #expect(user?.email == "test@test.com")
    }

    @Test func signIn_withEmptyEmail_returnsNil() async {
        let mock = MockAuthService()
        let viewModel = LoginViewModel(authService: mock)

        viewModel.email = ""
        viewModel.password = "123456"

        let user = await viewModel.signIn()

        #expect(user == nil)
        #expect(viewModel.errorMessage == "Informe seu e-mail")
    }

    @Test func signIn_withEmptyPassword_returnsNil() async {
        let mock = MockAuthService()
        let viewModel = LoginViewModel(authService: mock)

        viewModel.email = "test@test.com"
        viewModel.password = ""

        let user = await viewModel.signIn()

        #expect(user == nil)
        #expect(viewModel.errorMessage == "Informe sua senha")
    }

    @Test func signIn_withAuthError_setsErrorMessage() async {
        let mock = MockAuthService()
        mock.shouldSucceed = false
        let viewModel = LoginViewModel(authService: mock)

        viewModel.email = "test@test.com"
        viewModel.password = "123456"

        let user = await viewModel.signIn()

        #expect(user == nil)
        #expect(viewModel.errorMessage != nil)
    }
}
