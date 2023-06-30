//
//  RepositoryProtocol.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 16.05.23.
//

import Foundation

protocol LoginProtocol {
    func fetchLogin(identifier: String, password: String) async throws -> LoginData
}

protocol ProductProtocol {
    func fetchProduct(id: Int) async throws -> Product
}
