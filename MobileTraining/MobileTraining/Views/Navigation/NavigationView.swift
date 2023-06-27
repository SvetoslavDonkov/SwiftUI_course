//
//  NavigationView.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 14.05.23.
//

import SwiftUI
import Factory

struct AppNavigationView: View {
    let loginRepository = Container().loginRepository()
    let productRepository = Container().productRepository()
    @State private var isLoggedIn = false;
    
    var body: some View {
        NavigationView {
            if isLoggedIn {
                ProductView(productRepository: productRepository)
            } else {
                LoginView(isLoggedIn: $isLoggedIn, loginRepository: loginRepository)
            }
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavigationView()
    }
}
