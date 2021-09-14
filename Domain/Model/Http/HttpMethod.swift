//
//  HTTPMethod.swift
//  Domain
//
//  Created by Thiago B Claramunt on 14/09/21.
//

import Foundation

public struct HttpMethod: RawRepresentable, Equatable, Hashable {
    /// `CONNECT` method.
    public static let connect = HttpMethod(rawValue: "CONNECT")
    /// `DELETE` method.
    public static let delete = HttpMethod(rawValue: "DELETE")
    /// `GET` method.
    public static let get = HttpMethod(rawValue: "GET")
    /// `HEAD` method.
    public static let head = HttpMethod(rawValue: "HEAD")
    /// `OPTIONS` method.
    public static let options = HttpMethod(rawValue: "OPTIONS")
    /// `PATCH` method.
    public static let patch = HttpMethod(rawValue: "PATCH")
    /// `POST` method.
    public static let post = HttpMethod(rawValue: "POST")
    /// `PUT` method.
    public static let put = HttpMethod(rawValue: "PUT")
    /// `TRACE` method.
    public static let trace = HttpMethod(rawValue: "TRACE")
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
