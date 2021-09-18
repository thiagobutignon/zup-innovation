//
//  DisplayScreenViewSpy.swift
//  PresentationTests
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import Foundation
import Presentation

class DisplayScreenViewSpy: DisplayScreenView {
    var emit: ((DisplayScreenViewModel) -> Void)?
    
    func observe(completion: @escaping (DisplayScreenViewModel) -> Void) {
        self.emit = completion
    }
    
    func show(viewModel: DisplayScreenViewModel) {
        self.emit?(viewModel)
    }
}
