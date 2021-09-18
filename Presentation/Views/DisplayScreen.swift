//
//  DisplayScreen.swift
//  Presentation
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import Foundation
import Domain

public protocol DisplayScreenView {
    func show(viewModel: DisplayScreenViewModel)
}

public struct DisplayScreenViewModel: Equatable {
    public var data: BeagleComponent
    
    public init(data: BeagleComponent) {
        self.data = data
    }
}
