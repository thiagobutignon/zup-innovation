//
//  HTTPError.swift
//  Domain
//
//  Created by Thiago B Claramunt on 14/09/21.
//

import Foundation

public enum HTTPError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
