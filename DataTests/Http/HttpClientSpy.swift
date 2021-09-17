//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import Foundation
import Data
import Domain

class HttpClientSpy: HttpClient {
    var urls: [URL] = [URL]()
    var data: Data?
    var completion: ((Result<Data?, HttpError>) -> Void)?
    func request(data: HttpRequest, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(data.url)
        self.data = data.body
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data) {
        completion?(.success(data))
    }
}

