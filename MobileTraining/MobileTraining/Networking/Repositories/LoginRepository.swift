//
//  PostRepository.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 16.05.23.
//

import Foundation
import Factory

class LoginRepository: LoginProtocol {
    private let networkManager = Container.shared.networkManager()
    
    func fetchLogin(identifier: String, password: String) async throws -> LoginData {
        let url = "\(AppURL.baseUrl)\(AppURL.loginRoute)"
        let parameters = [
            "identifier": identifier,
            "password": password
        ]
        
        return try await networkManager.request(url, method: .post, parameters: parameters)
    }
}
