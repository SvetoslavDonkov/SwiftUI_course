//
//  LoginView.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 14.05.23.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var showingAlert = false
    @State private var isSecure = true
    
    init(isLoggedIn: Binding<Bool>, loginRepository: LoginRepository) {
        self._isLoggedIn = isLoggedIn
        self.loginViewModel = LoginViewModel(loginRepository: loginRepository)
    }
    
    var body: some View {
        VStack {
            TextField("Email", text: $loginViewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
                .padding(.horizontal)
            
            if !loginViewModel.isEmailValid {
                HStack {
                    Text("Ivalid email")
                        .foregroundColor(.red)
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            PasswordField(password: $loginViewModel.password, isSecure: $isSecure)
            
            Button("Login") {
                if loginViewModel.validateEmail() {
                    loginViewModel.login { success in
                        if success {
                            isLoggedIn = true
                        } else {
                            showingAlert = true
                        }
                        loginViewModel.password = ""
                    }
                }
            }
            .padding()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Login Failed"), message: Text("Your email or password is incorrect. Please try again."), dismissButton: .default(Text("OK")))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("LoginBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct PasswordField: View {
    @Binding var password: String
    @Binding var isSecure: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecure {
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .padding()
            } else {
                TextField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .padding()
            }
            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.secondary)
                    .padding()
            }
            .padding(.trailing)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let loginRepository = LoginRepository()
        return LoginView(isLoggedIn: .constant(false), loginRepository: loginRepository)
    }
}
