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
        Factory(self) { NetworkManager() }
            .singleton
    }
    
    var loginRepository: Factory<LoginRepository> {
        Factory(self) { LoginRepository() }
    }
    
    var productRepository: Factory<ProductRepository> {
        Factory(self) { ProductRepository() }
    }
    
    var keychainStorage: Factory<KeychainStorage> {
        Factory(self) { KeychainStorage() }
    }
}
