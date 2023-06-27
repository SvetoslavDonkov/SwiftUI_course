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
    
    private let networkManager: NetworkManager
    
    init(isLoggedIn: Binding<Bool>, loginRepository: LoginRepository,
         networkManager: NetworkManager) {
        self._isLoggedIn = isLoggedIn
        self.loginViewModel = LoginViewModel(loginRepository: loginRepository)
        self.networkManager = networkManager
        
        // Revoke access token in keychain
        networkManager.interceptor.storeAccessToken(nil)
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
                    loginViewModel.login { success, userData in
                        if success {
                            networkManager.interceptor.storeAccessToken(userData?.jwt)
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
        let networkManager = NetworkManager()
        return LoginView(isLoggedIn: .constant(false), loginRepository: loginRepository, networkManager: networkManager)
    }
}
