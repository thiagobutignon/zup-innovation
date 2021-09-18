//
//  ScreenRequest.swift
//  Presentation
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import Foundation
import Domain

public struct ScreenRequest: Model {
    public var beagleComponent: String?
    public var style: Style?
    public var children: [Children]?
    
    public init(beagleComponent: String?, style: Style?, children: [Children]?) {
        self.beagleComponent = beagleComponent
        self.style = style
        self.children = children
    }
    
    public func toScreenRequestModel() -> ScreenRequest {
        return ScreenRequest(beagleComponent: beagleComponent!, style: style!, children: children!)
    }
}
