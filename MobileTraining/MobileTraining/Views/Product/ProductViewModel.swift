//
//  ProductViewModel.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 28.05.23.
//

import Foundation
import Factory

class ProductViewModel: ObservableObject {
    private let productRepository = Container.shared.productRepository()
    
    @Published var id = 1
    @Published var product = Product()
    @Published var loading = true
    
    func getProduct() {
        Task {
            /// try await Task.sleep(nanoseconds: 10 * 1_000_000_000)
            do {
                self.product = try await productRepository.fetchProduct(id: self.id)
                loading = false
            } catch {
                print("Fetching Product Error: \(error)")
                
            }
        }
    }
}
