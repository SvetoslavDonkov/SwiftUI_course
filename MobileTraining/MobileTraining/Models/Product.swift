//
//  Product.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 24.05.23.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let short_description: String
    let stock: Int
    let price: Double
    let rating: Int
    let image: String
    let category: String
}
