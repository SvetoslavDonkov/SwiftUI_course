//
//  NetworkManager.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 16.05.23.
//

import Foundation
import Alamofire

class NetworkManager {
    private let session: Session
    private let interceptor = Interceptor()
    
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

protocol AccessTokenStorage: AnyObject {
    typealias JWT = String
    var jwt: JWT { get set }
}

final class Interceptor: RequestInterceptor {
    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjg3MDg4NTkwLCJleHAiOjE2ODk2ODA1OTB9.yo1PdRHd-7Q9p0jZw0JkBS7t_mUGTsnKh5fuxOvxy_0"
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix("https://ethereal-artefacts.fly.dev/api/auth/local") == false else {
            return completion(.success(urlRequest))
        }
        
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: accessToken))
        
        completion(.success(urlRequest))
    }
}
