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
        label.autoResizingOff()
        label.textColor = UIColor(hex: textColor)
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = text
        fatherView.addSubviews([label])
        label.edgeToSuperView(margin: margin)
        return label
    }
    
    static func container(backgroundColor: String, fatherView: UIView, padding: Int, margin: Int?) -> UIView {
        let container = UIView()
        container.autoResizingOff()
        container.backgroundColor = UIColor(hex: backgroundColor)
        fatherView.addSubviews([container])
        if (margin != nil) {
            var makeDistance = padding
            if(fatherView.subviews.count != 1) {
                makeDistance = 100 * (fatherView.subviews.count - 1) + padding + (margin! * fatherView.subviews.count - 1)
               
            }
            print(makeDistance)
            container.height(100)
                     .topToTop(of: fatherView, margin: CGFloat(makeDistance))
                     .leadingToLeading(of: fatherView, margin: CGFloat(padding))
                     .trailingToTrailing(of: fatherView, margin: -CGFloat(padding))
            
        } else {
            container.edgeToSuperView(margin: CGFloat(padding))
        }
        
        return container
    }
    
    static func containerFather(backgroundColor: String, fatherView: UIView, padding: Int) -> UIView {
        let container = UIView()
        container.autoResizingOff()
        container.backgroundColor = UIColor(hex: backgroundColor)
        fatherView.addSubviews([container])
        container.topToTop(of: fatherView, margin: CGFloat(padding))
                 .leadingToLeading(of: fatherView)
                 .trailingToTrailing(of: fatherView)
                 .height(250)
        return container
    }
}
