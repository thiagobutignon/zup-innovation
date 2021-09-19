//
//  ScreenViewController.swift
//  UI
//
//  Created by Thiago B Claramunt on 18/09/21.
//

import UIKit
import Presentation

public final class ScreenViewController: UIViewController {
    public var screen: Screen?
    var viewModel: DisplayScreenViewModel?
    public var loadScreen: ((ScreenRequest) -> Void)?
    
    public override func loadView() {
        self.screen = Screen()
        self.view = self.screen
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "Screen"
        let viewModel = ScreenRequest(beagleComponent: nil, style: nil, children: nil)
        loadScreen?(viewModel)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension ScreenViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            self.screen?.loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            self.screen?.loadingIndicator.stopAnimating()
        }
    }
}

extension ScreenViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert: UIAlertController = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok!", style: .default))
        present(alert, animated: true)
    }
}

extension ScreenViewController: DisplayScreenView {
    public func show(viewModel: DisplayScreenViewModel) {
        self.viewModel = viewModel
        let data = viewModel.data
        let _ = ChildBuilder.container(backgroundColor: data.style!.backgroundColor, fatherView: self.view, margin: (data.style?.padding?.all.value)!)
    }
}
