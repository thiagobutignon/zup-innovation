//
//  WeakVarProxy.swift
//  Main
//
//  Created by Thiago B Claramunt on 19/09/21.
//

import Foundation
import Presentation
import Domain

class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}

extension WeakVarProxy: DisplayScreenView where T: DisplayScreenView {
    func show(viewModel: DisplayScreenViewModel) {
        instance?.show(viewModel: viewModel)
    }
}

