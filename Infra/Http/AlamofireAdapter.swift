//
//  AlamofireAdapter.swift
//  Infra
//
//  Created by Thiago B Claramunt on 14/09/21.
//

import Foundation
import Data
import Domain
import Alamofire

public final class AlamofireAdapter: HttpClient {
    private let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func request(data: HttpRequest, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        session.request(data.url, method: .init(rawValue: data.method.rawValue), parameters: data.body?.toJson(), encoding: JSONEncoding.default).responseData { (dataResponse) in
            guard let statusCode = dataResponse.response?.statusCode else { return completion(.failure(.noConnectivity))}
            
            switch dataResponse.result {
                case .failure:
                    completion(.failure(.noConnectivity))
                case .success(let data):
                    switch statusCode {
                        case 204:
                            completion(.success(nil))
                        case 200...299:
                            completion(.success(data))
                        case 401:
                            completion(.failure(.unauthorized))
                        case 403:
                            completion(.failure(.forbidden))
                        case 400...499:
                            completion(.failure(.badRequest))
                        case 500...599:
                            completion(.failure(.serverError))
                        default:
                            completion(.failure(.noConnectivity))
                    }
            }
        }
    }
}
