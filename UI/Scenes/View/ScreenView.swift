//
//  Screen.swift
//  UI
//
//  Created by Thiago B Claramunt on 19/09/21.
//

import UIKit

public final class ScreenView: UIView {
    public var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.autoResizingOff()
        return activityIndicatorView
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.configSuperView()
        self.setupConstraints()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Screen init(coder: \(coder) has not been implemented")
    }
    
    private func configSuperView() {
        self.addSubview(self.loadingIndicator)
    }
    
    private func setupConstraints() {
        self.loadingIndicator.centerY(of: self)
        self.loadingIndicator.centerX(of: self)
    }
}
