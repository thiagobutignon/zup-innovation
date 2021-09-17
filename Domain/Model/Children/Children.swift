//
//  Children.swift
//  Domain
//
//  Created by Thiago B Claramunt on 16/09/21.
//

import Foundation

public struct Children: Model {
    public var beagleComponent: String
    public var style: Style?
    public var text: String?
    public var textColor: String?
    public var children: [Children]?
    
    public enum CodingKeys: String, CodingKey {
        case beagleComponent = "_beagleComponent_"
        case style
        case children
        case text
        case textColor
    }
    
    public init(beagleComponent: String, style: Style?, text: String?, textColor: String?, children: [Children]?) {
        self.beagleComponent = beagleComponent
        self.style = style
        self.text = text
        self.textColor = textColor
        self.children = children
    }
}
