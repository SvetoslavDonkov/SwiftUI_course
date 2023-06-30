//
//  NetworkManager.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 16.05.23.
//

import Foundation
import Alamofire
import Factory

class NetworkManager {
    private let session: Session
    let interceptor = Interceptor()
    
    init() {
        // Create custom session configuration
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // Set custom timeout
        
        // Initialize the custom session with the configuration
        self.session = Session(configuration: configuration, interceptor: interceptor)
    }
    
    func request<T: Decodable>(_ url: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            session.request(url, method: method, parameters: parameters)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}

struct Interceptor: RequestInterceptor {
    private let keychainStorage = Container.shared.keychainStorage()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let accessToken = keychainStorage.keychain[keychainStorage.accessTokenKey] else {
            return completion(.success(urlRequest))
        }
        
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: accessToken))
        
        completion(.success(urlRequest))
    }
}
