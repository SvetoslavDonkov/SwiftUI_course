//
//  ProductRepository.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 28.05.23.
//

import Foundation

class ProductRepository: ProductProtocol {
    private let networkManager = NetworkManager()
    
    func fetchProduct(id: Int) async throws -> Product {
        let url = "https://ethereal-artefacts.fly.dev/api/products/\(id)?populate=*"
        return try await networkManager.request(url, method: .get)
    }
}
