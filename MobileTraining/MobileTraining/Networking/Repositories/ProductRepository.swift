//
//  ProductRepository.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 28.05.23.
//

import Foundation
import Factory

class ProductRepository: ProductProtocol {
    private let networkManager = Container.shared.networkManager()
    
    func fetchProduct(id: Int) async throws -> Product {
        return try await networkManager.request(AppURL.productsUrl(id), method: .get)
    }
}
