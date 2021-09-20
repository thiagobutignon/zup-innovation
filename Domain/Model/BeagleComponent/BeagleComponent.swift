//
//  BeagleComponent.swift
//  Domain
//
//  Created by Thiago B Claramunt on 16/09/21.
//

import Foundation

public struct BeagleComponent: Model, ComponentLayer {
    public var beagleComponent: String
    public var style: Style?
    public var children: [Children]?
    
    public enum CodingKeys: String, CodingKey {
        case beagleComponent = "_beagleComponent_"
        case style
        case children
    }
    
    public init(beagleComponent: String, style: Style?, children: [Children]?) {
        self.beagleComponent = beagleComponent
        self.style = style
        self.children = children
    }
}
