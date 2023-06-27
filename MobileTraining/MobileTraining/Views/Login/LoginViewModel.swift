//
//  LoginViewModel.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 14.05.23.
//

import Foundation

class LoginViewModel: ObservableObject {
    private let loginRepository: LoginRepository
    
    @Published var email = ""
    @Published var password = ""
    @Published var isEmailValid = true
    @Published var login: Login
    @Published var isLoginRequestRunning = false
    
    init(loginRepository: LoginRepository) {
        self.login = Login(jwt: "", user: User(id: 0, username: "", email: "", provider: "", confirmed: false, blocked: false))
        self.loginRepository = loginRepository
    }
    
    func login(success: @escaping (Bool, Login?) -> Void) {
        isLoginRequestRunning = true
        Task {
            /// Delay request by a couple of seconds in order to test disabled button
            /// try await Task.sleep(nanoseconds: 10 * 1_000_000_000)
            do {
                self.login = try await loginRepository.fetchLogin(identifier: self.email, password: self.password)
                success(true, login)
            } catch {
                print("Login Error: \(error)")
                success(false, nil)
            }
            isLoginRequestRunning = false
        }
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        isEmailValid = emailPredicate.evaluate(with: email)
        return isEmailValid
    }
}
