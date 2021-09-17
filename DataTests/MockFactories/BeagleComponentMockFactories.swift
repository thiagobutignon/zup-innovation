//
//  BeagleComponentMockFactories.swift
//  DataTests
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import Foundation
import Domain


public func makeBeagleComponentChildrenWithText(backgroundColor: String, text: String) -> Children {
    return Children(beagleComponent: "beagle:container", style: Style(backgroundColor: backgroundColor, padding: Style.Padding(all: Style.Padding.All(value: 20, type: "REAL")), margin: Style.Margin(vertical: Style.Margin.Vertical(value: 10, type: "REAL"))), text: nil, textColor: nil, children: [makeBeagleComponentText(text: text)])
}

public func makeBeagleComponentChildrenBoxOnly(backgroundColor: String, paddingValue: Int, children: Children) -> Children {
    return Children(beagleComponent: "beagle:container", style: Style(backgroundColor: backgroundColor, padding: Style.Padding(all: Style.Padding.All(value: paddingValue, type: "REAL")), margin: nil), text: nil, textColor: nil, children: [children])
}

public func makeBeagleComponentText(text: String) -> Children {
    return Children(beagleComponent: "beagle:text", style: nil, text: text, textColor: "#FFFFFF", children: nil)
}

public func makeJSONBoxedText() -> BeagleComponent {
    return BeagleComponent(beagleComponent: "beagle:container", style: Style(backgroundColor: "#FF0000", padding: Style.Padding(all: Style.Padding.All(value: 60, type: "REAL")), margin: nil), children: [makeBeagleComponentChildrenBoxOnly(backgroundColor: "#00FF00", paddingValue: 40, children: makeBeagleComponentChildrenBoxOnly(backgroundColor: "#0000FF", paddingValue: 20, children: makeBeagleComponentText(text: "Hello World!")))])
}

public func makeJSONMultipleBoxes() -> BeagleComponent {
    BeagleComponent(beagleComponent: "beagle:container", style: nil, children: [makeBeagleComponentChildrenWithText(backgroundColor: "#AA0000", text: "Hello"), makeBeagleComponentChildrenWithText(backgroundColor: "#008800", text: "Zup"), makeBeagleComponentChildrenWithText(backgroundColor: "#0000AA", text: "IT!")])
}

