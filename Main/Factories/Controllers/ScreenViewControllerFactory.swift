//
//  ScreenViewControllerFactoryt.swift
//  Main
//
//  Created by Thiago B Claramunt on 19/09/21.
//

import Foundation
import UI
import Presentation
import Domain

public func makeScreenBoxedText() -> ScreenViewController {
    return makeScreenViewControllerWith(screen: makeRemoteScreenBoxedText())
}

public func makeScreenMultipleBoxes() -> ScreenViewController {
    return makeScreenViewControllerWith(screen: makeRemoteScreenMultipleBoxes())
}

public func makeScreenControllerBoxedText() -> ScreenViewController {
    return makeScreenViewControllerWith(screen: makeRemoteScreenBoxedText())
}

public func makeScreenControllerMultipleBox() -> ScreenViewController {
    return makeScreenViewControllerWith(screen: makeRemoteScreenMultipleBoxes())
}

public func makeScreenViewControllerWith(screen: Screen) -> ScreenViewController {
    let controller = ScreenViewController()
    let presenter = ScreenPresenter(displayScreenView: WeakVarProxy(controller), alertView: WeakVarProxy(controller), loadingView: WeakVarProxy(controller), screen: screen)
    controller.loadScreen = presenter.show
    return controller
}

