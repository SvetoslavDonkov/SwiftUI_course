//
//  NavigationView.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 14.05.23.
//

import SwiftUI

struct AppNavigationView: View {
    @State private var isLoggedIn = false;
    
    var body: some View {
        NavigationView {
            if isLoggedIn {
                ProductView(product: sampleProduct)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavigationView()
    }
}
