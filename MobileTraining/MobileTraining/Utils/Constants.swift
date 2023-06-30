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
    static let loginUrl = "https://ethereal-artefacts.fly.dev/api/auth/local"
    static let productsUrl: (Int) -> String = {
        return "https://ethereal-artefacts.fly.dev/api/products/\($0)?populate=*"
    }
}

struct StringConstants {
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
}
