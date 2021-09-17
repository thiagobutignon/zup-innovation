//
//  StyleProperties.swift
//  Domain
//
//  Created by Thiago B Claramunt on 16/09/21.
//

import Foundation

public struct StyleProperties: Model {
    public var value: Int
    public var type: String
    
    public init(value: Int, type: String) {
        self.value = value
        self.type = type
    }
}
