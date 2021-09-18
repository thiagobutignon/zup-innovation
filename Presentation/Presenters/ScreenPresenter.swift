//
//  ScreenPresenter.swift
//  Presentation
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import Foundation
import Domain

public final class ScreenPresenter {
    private var displayScreenView: DisplayScreenView
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let screen: Screen
    
    public init(displayScreenView: DisplayScreenView, alertView: AlertView, loadingView: LoadingView, screen: Screen) {
        self.displayScreenView = displayScreenView
        self.alertView = alertView
        self.loadingView = loadingView
        self.screen = screen
    }
    
    public func show(viewModel: ScreenRequest) {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        screen.performs { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            switch result {
                case .failure:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Você está sem conexão, tente novamente mais tarde"))
                case .success(let data):
                    self.displayScreenView.show(viewModel: DisplayScreenViewModel(data: data))
            }
        }
    }
}
