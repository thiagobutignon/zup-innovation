//
//  GetScreen.swift
//  Domain
//
//  Created by Thiago B Claramunt on 16/09/21.
//

import Foundation

public protocol Screen {
    typealias Result = Swift.Result<BeagleComponent, DomainError>
    func performs(completion: @escaping (Result)-> Void)
}
