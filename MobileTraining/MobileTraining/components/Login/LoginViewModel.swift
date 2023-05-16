//
//  LoginViewModel.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 14.05.23.
//

import Foundation

class LoginViewModel: ObservableObject {
    let exampleEmail = "example@email.com"
    let examplePassword = "123"
    
    @Published var email = ""
    @Published var password = ""
    @Published var isEmailValid = true
    
    func login(success: @escaping (Bool) -> Void) {
        if (self.email == self.exampleEmail && self.password == self.examplePassword) {
            success(true)
        }
        success(false)
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        isEmailValid = emailPredicate.evaluate(with: email)
        return isEmailValid
    }
}
