//
//  LoginView.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 14.05.23.
//

import SwiftUI
import Factory

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var isSecure = true
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)
                
                if !viewModel.isEmailValid {
                    HStack {
                        Text("Ivalid email")
                            .foregroundColor(.red)
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                PasswordField(password: $viewModel.password, isSecure: $isSecure)
                
                Button("Login") {
                    viewModel.login {
                        if $0 {
                            path.append(Path.product)
                        }
                    }
                }
                .disabled(viewModel.isLoginRequestRunning)
                .padding()
            }
            .navigationDestination(for: String.self) {
                if $0 == Path.product {
                    ProductView()
                }
            }
            .alert(isPresented: $viewModel.showingAlert) {
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
