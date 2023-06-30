//
//  Post.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 24.05.23.
//

import Foundation

struct LoginData: Codable {
    let jwt: String?
    let user: User?
    
    init(jwt: String? = nil, user: User? = nil) {
        self.jwt = jwt
        self.user = user
    }
}

struct User: Codable, Identifiable {
    let id: Int
    let username: String
    let email: String
    let provider: String
    let confirmed: Bool
    let blocked: Bool
}
