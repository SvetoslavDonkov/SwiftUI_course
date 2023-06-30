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
        let url = "\(AppURL.baseUrl)\(AppURL.productsRoute)/\(id)"
        let parameters = ["populate": "*"]
        
        return try await networkManager.request(url, method: .get, parameters: parameters)
    }
}
