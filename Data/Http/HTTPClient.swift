//
//  HttpClient.swift
//  Data
//
//  Created by Thiago B Claramunt on 14/09/21.
//

import Foundation
import Domain

public protocol HTTPClient {
    func request(data: HttpRequest, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
