//
//  HTTPRequest.swift
//  Domain
//
//  Created by Thiago B Claramunt on 14/09/21.
//

import Foundation

public struct HttpRequest {
    public var url: URL
    public var method: HttpMethod
    public var body: Data?
    public var headers: [String: String]?
    
    public init(url: URL, method: HttpMethod, body: Data?, headers: [String: String]? = nil) {
        self.url = url
        self.method = method
        self.body = body
        self.headers = headers
    }
}
