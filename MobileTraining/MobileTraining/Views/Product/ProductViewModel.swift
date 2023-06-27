//
//  ProductViewModel.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 28.05.23.
//

import Foundation

class ProductViewModel: ObservableObject {
    private let productRepository: ProductRepository
    
    @Published var id = 1
    @Published var product: Product
    
    init(productRepository: ProductRepository) {
        self.product = Product(id: 0, title: "", description: "", short_description: "", stock: 0, price: 0, rating: 0, image: "", category: "")
        self.productRepository = productRepository
    }
    
    func getProduct(success: @escaping (Bool) -> Void) {
        Task {
            do {
                self.product = try await productRepository.fetchProduct(id: self.id)
                print(self.product)
                success(true)
            } catch {
                print("Fetching Product Error: \(error)")
                success(false)
            }
        }
    }
}
