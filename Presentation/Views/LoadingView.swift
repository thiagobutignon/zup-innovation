//
//  LoadingView.swift
//  Presentation
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import Foundation

public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}

public struct LoadingViewModel: Equatable {
    public var isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}
