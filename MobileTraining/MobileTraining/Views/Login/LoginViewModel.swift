//
//  LoginViewModel.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 14.05.23.
//

import Foundation
import Factory

class LoginViewModel: ObservableObject {
    private let loginRepository = Container.shared.loginRepository()
    private let keychainStorage = Container.shared.keychainStorage()
    
    @Published var email = ""
    @Published var password = ""
    @Published var isEmailValid = true
    @Published var userLoginData = LoginData()
    @Published var isLoginRequestRunning = false
    @Published var showingAlert = false
    
    init() {
        keychainStorage.storeAccessToken(nil)
    }
    
    func login(success: @escaping (Bool) -> Void) {
        isEmailValid = email.validateEmail()
        if isEmailValid {
            isLoginRequestRunning = true
            Task {
                /// Delay request by a couple of seconds in order to test disabled button
                /// try await Task.sleep(nanoseconds: 10 * 1_000_000_000)
                do {
                    self.userLoginData = try await loginRepository.fetchLogin(identifier: self.email, password: self.password)
                    keychainStorage.storeAccessToken(userLoginData.jwt)
                    
                    success(true)
                } catch {
                    self.showingAlert = true
                    print("Login Error: \(error)")
                    
                    success(false)
                    
                }
                password = ""
                isLoginRequestRunning = false
            }
        }
    }
}
