//
//  Product.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 24.05.23.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int?
    let title: String?
    let description: String?
    let shortDescription: String?
    let stock: Int?
    let price: Double?
    let rating: Int?
    let image: String?
    let category: String?
    
    init(id: Int? = nil, title: String? = nil, description: String? = nil, shortDescription: String? = nil, stock: Int? = nil, price: Double? = nil, rating: Int? = nil, image: String? = nil, category: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.shortDescription = shortDescription
        self.stock = stock
        self.price = price
        self.rating = rating
        self.image = image
        self.category = category
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case shortDescription = "short_description"
        case stock
        case price
        case rating
        case image
        case category
    }
}
