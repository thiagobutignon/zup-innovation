//
//  ScreenViewController.swift
//  UI
//
//  Created by Thiago B Claramunt on 18/09/21.
//

import UIKit
import Presentation
import Domain

public final class ScreenViewController: UIViewController {
    public var screenView: ScreenView?
    var viewModel: DisplayScreenViewModel?
    public var loadScreen: ((ScreenRequest) -> Void)?
    
    public override func loadView() {
        self.screenView = ScreenView()
        self.view = self.screenView
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
            self.screenView?.loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            self.screenView?.loadingIndicator.stopAnimating()
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
        let data: BeagleComponent = viewModel.data
        var backgroundColor = "#FFF"
        var paddingValue = 20
        let style = data.style
        if let newBackgroundColor = style?.backgroundColor {
            backgroundColor = newBackgroundColor
        }
        if let newPaddingValue = style?.padding?.all.value {
            paddingValue = newPaddingValue
        }
        let firstView = ChildBuilder.containerFather(backgroundColor: backgroundColor, fatherView: self.view, padding: paddingValue)
        for item in data.children! {
            recursive(data: item, fatherView: firstView)
        }
    }
    
    func recursive(data: Children?, fatherView: UIView) {
        guard let data = data else { return }
            switch data.beagleComponent {
                case "beagle:container":
                    var margin: Int? = nil
                    if let newMargin: Int = data.style?.margin?.vertical.value {
                        margin = newMargin
                    }
                    let newView = ChildBuilder.container(backgroundColor: (data.style!.backgroundColor), fatherView: fatherView, padding: (data.style?.padding!.all.value)!, margin: margin)
                    recursive(data: data.children![0], fatherView: newView)
                case "beagle:text":
                    let _ = ChildBuilder.title(text: (data.text)!, textColor: (data.textColor)!, fatherView: fatherView, margin: 10)
                default:
                    break
            
        }
    }
}
