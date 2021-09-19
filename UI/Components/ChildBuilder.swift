//
//  Container.swift
//  UI
//
//  Created by Thiago B Claramunt on 18/09/21.
//

import UIKit

public class ChildBuilder {
    static func title(text: String, textColor: String, fatherView: UIView, margin: CGFloat) -> UIView {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: textColor)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = text
        fatherView.addSubviews([label])
        label.edgeToSuperView(margin: margin)
        return label
    }
    
    static func container(backgroundColor: String, fatherView: UIView, margin: Int) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(hex: backgroundColor)
        fatherView.addSubviews([container])
        container.edgeToSuperView(margin: CGFloat(margin))
        return container
    }
}
