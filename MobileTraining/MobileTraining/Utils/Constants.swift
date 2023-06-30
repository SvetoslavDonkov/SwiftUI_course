//
//  Constants.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 29.06.23.
//

import Foundation

struct Path {
    static let product = "product"
}

struct AppURL {
    static let baseUrl = "https://ethereal-artefacts.fly.dev/api/"
    static let loginRoute = "auth/local"
    static let productsRoute = "products"
}

struct StringConstants {
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
}
