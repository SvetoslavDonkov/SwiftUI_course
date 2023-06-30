//
//  KeychainRepository.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 30.06.23.
//

import Foundation
import Factory

class KeychainRepository: KeychainProtocol {
    private let keychain = Keychain(service: "com.accedia.svdo.MobileTraining.keychain")
    
    func fetchProduct(id: Int) async throws -> Product {
        return try await networkManager.request(URL.productsUrl(id), method: .get)
    }
}
