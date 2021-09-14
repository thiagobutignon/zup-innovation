//
//  HTTPStatusCode.swift
//  Domain
//
//  Created by Thiago B Claramunt on 14/09/21.
//

import Foundation

public enum HttpStatusCode: Int {
    case ok = 200
    case noContent = 204
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case serverError = 500
}
