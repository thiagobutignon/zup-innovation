//
//  RemoteScreen.swift
//  Data
//
//  Created by Thiago B Claramunt on 16/09/21.
//

import Foundation
import Domain

public final class RemoteScreen: Screen {
    private let url: URL
    private let httpClient: HttpClient
    
    public init(url: URL, httpClient: HttpClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func performs(completion: @escaping (Screen.Result) -> Void) {
        httpClient.request(data: HttpRequest.init(url: url, method: .get, body: nil)) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let data):
                    if let model: BeagleComponent = data?.toModel() {
                        completion(.success(model))
                    } else {
                        completion(.failure(.unableToParsing))
                    }
                case .failure(let error):
                    switch error {
                        case .badRequest:
                            completion(.failure(.badRequest))
                        case .serverError: completion(.failure(.unexpected))
                        default:
                            print("Unkown error: \(error)")
                            completion(.failure(.unexpected))
                    }
            }
        }
    }
}
