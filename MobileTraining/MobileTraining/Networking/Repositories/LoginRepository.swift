//
//  PostRepository.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 16.05.23.
//

import Foundation

class LoginRepository: LoginProtocol {
    private let networkManager = NetworkManager()
    
    func fetchLogin(identifier: String, password: String) async throws -> Login {
        let url = "https://ethereal-artefacts.fly.dev/api/auth/local"
        let parameters: [String: String] = [
            "identifier": identifier,
            "password": password
        ]
        return try await networkManager.request(url, method: .post, parameters: parameters)
    }
}
