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
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        print(String(data: try! jsonEncoder.encode(data), encoding: .utf8)!)
        let firstView = ChildBuilder.container(backgroundColor: data.style!.backgroundColor, fatherView: self.view, margin: (data.style?.padding?.all.value)!)
        recursive(data: data, fatherView: firstView)
    }
    
    func recursive(data: BeagleComponent, fatherView: UIView) {
        if(data.children != nil) {
            let newData = data.children?[0]
            switch newData!.beagleComponent {
                case "beagle:container":
                    let newView = ChildBuilder.container(backgroundColor: (newData?.style!.backgroundColor)!, fatherView: fatherView, margin: (newData?.style?.padding!.all.value)!)
                    recursive(data: newData!, fatherView: newView)
                case "beagle:text":
                    let newView = ChildBuilder.title(text: (newData?.text)!, textColor: (newData?.textColor)!, fatherView: fatherView, margin: 10)
                    recursive(data: newData!, fatherView: newView)
                default:
                    break
            }
        }
    }
    
    func recursive(data: Children, fatherView: UIView) {
        if(data.children != nil) {
            let newData = data.children?[0]
            switch newData!.beagleComponent {
                case "beagle:container":
                    let newView = ChildBuilder.container(backgroundColor: (newData?.style!.backgroundColor)!, fatherView: fatherView, margin: (newData?.style?.padding!.all.value)!)
                    recursive(data: newData!, fatherView: newView)
                case "beagle:text":
                    let newView = ChildBuilder.title(text: (newData?.text)!, textColor: (newData?.textColor)!, fatherView: fatherView, margin: 10)
                    recursive(data: newData!, fatherView: newView)
                default:
                    break
            }
        }
    }
}
