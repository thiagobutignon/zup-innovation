//
//  HttpClient.swift
//  Data
//
//  Created by Thiago B Claramunt on 14/09/21.
//

import Foundation
import Domain

public protocol HTTPClient {
    func request(data: HTTPRequest, completion: @escaping (Result<Data?, HTTPError>) -> Void)
}
