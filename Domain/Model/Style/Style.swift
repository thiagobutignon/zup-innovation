//
//  Style.swift
//  Domain
//
//  Created by Thiago B Claramunt on 16/09/21.
//

import Foundation

public struct Style: Model {
    public struct Padding: Model {
        public typealias All = StyleProperties
        public var all: All
        
        public init(all: All) {
            self.all = all
        }
    }
    
    public struct Margin: Model {
        public typealias Vertical = StyleProperties
        public var vertical: Vertical
        
        public init(vertical: Vertical) {
            self.vertical = vertical
        }
    }
    public var backgroundColor: String
    public var padding: Padding?
    public var margin: Margin?
    
    public init(backgroundColor: String, padding: Padding?, margin: Margin?) {
        self.backgroundColor = backgroundColor
        self.padding = padding
        self.margin = margin
    }
}
