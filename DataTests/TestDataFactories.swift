//
//  TestDataFactories.swift
//  DataTests
//
//  Created by Thiago B Claramunt on 14/09/21.
//

import Foundation

func makeUrl() -> URL {
    return URL(string: "http://any-url.com")!
}

func makeEmptyData() -> Data {
    return Data()
}

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    return Data("{\"name\":\"Thiago\"}".utf8)
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
