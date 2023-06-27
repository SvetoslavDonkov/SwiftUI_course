//
//  FactoryExtensions.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 24.05.23.
//

import Foundation
import Factory

extension Container {
    var networkManager: Factory<NetworkManager> {
        self { NetworkManager() }
            .singleton
    }
    
    var loginRepository: Factory<LoginRepository> {
        self { LoginRepository() }
    }
    
    var productRepository: Factory<ProductRepository> {
        self { ProductRepository() }
    }
}
