//
//  RemoteBeagleTests.swift
//  DataTests
//
//  Created by Thiago B Claramunt on 16/09/21.
//

import Foundation
import XCTest
import Domain

class RemoteBeagleTests: XCTestCase {
    func test_decode_boxed_json() throws {
        let givenJsonData = #"""
            {
            "_beagleComponent_": "beagle:container",
            "style": {
            "backgroundColor": "#FF0000",
            "padding": {
            "all": {
            "value": 60,
            "type": "REAL"
            }
            }
            },
            "children": [
            {
            "_beagleComponent_": "beagle:container",
            "style": {
            "backgroundColor": "#00FF00",
            "padding": {
            "all": {
            "value": 40,
            "type": "REAL"
            }
            }
            },
            "children": [
            {
            "_beagleComponent_": "beagle:container",
            "style": {
            "backgroundColor": "#0000FF",
            "padding": {
            "all": {
            "value": 20,
            "type": "REAL"
            }
            }
            },
            "children": [
            {
            "_beagleComponent_": "beagle:text",
            "text": "Hello World!",
            "textColor": "#FFFFFF"
            }
            ]
            }
            ]
            }
            ]
            }
"""#.data(using: .utf8)!
        let result = try JSONDecoder().decode(BeagleComponent.self, from: givenJsonData)
        let expected: BeagleComponent = BeagleComponent(beagleComponent: "beagle:container", style: Style(backgroundColor: "#FF0000", padding: Style.Padding(all: Style.Padding.All(value: 60, type: "REAL")), margin: nil), children: [makeBeagleComponentChildrenBoxOnly(backgroundColor: "#00FF00", paddingValue: 40, children: makeBeagleComponentChildrenBoxOnly(backgroundColor: "#0000FF", paddingValue: 20, children: makeBeagleComponentText(text: "Hello World!")))])
        XCTAssertEqual(result, expected)
    }
    
    func test_decode_multiple_boxes_json() throws {
        let givenJsonData = #"""
            {
            "_beagleComponent_": "beagle:container",
            "children": [
            {
            "_beagleComponent_": "beagle:container",
            "style": {
            "backgroundColor": "#AA0000",
            "padding": {
            "all": {
            "value": 20,
            "type": "REAL"
            }
            },
            "margin": {
            "vertical": {
            "value": 10,
            "type": "REAL"
            }
            }
            },
            "children": [
            {
            "_beagleComponent_": "beagle:text",
            "text": "Hello",
            "textColor": "#FFFFFF"
            }
            ]
            },
            {
            "_beagleComponent_": "beagle:container",
            "style": {
            "backgroundColor": "#008800",
            "padding": {
            "all": {
            "value": 20,
            "type": "REAL"
            }
            },
            "margin": {
            "vertical": {
            "value": 10,
            "type": "REAL"
            }
            }
            },
            "children": [
            {
            "_beagleComponent_": "beagle:text",
            "text": "Zup",
            "textColor": "#FFFFFF"
            }
            ]
            },
            {
            "_beagleComponent_": "beagle:container",
            "style": {
            "backgroundColor": "#0000AA",
            "padding": {
            "all": {
            "value": 20,
            "type": "REAL"
            }
            },
            "margin": {
            "vertical": {
            "value": 10,
            "type": "REAL"
            }
            }
            },
            "children": [
            {
            "_beagleComponent_": "beagle:text",
            "text": "IT!",
            "textColor": "#FFFFFF"
            }
            ]
            }
            ]
            }
"""#.data(using: .utf8)!
        let result = try JSONDecoder().decode(BeagleComponent.self, from: givenJsonData)
        let expected: BeagleComponent = BeagleComponent(beagleComponent: "beagle:container", style: nil, children: [makeBeagleComponentChildrenWithText(backgroundColor: "#AA0000", text: "Hello"), makeBeagleComponentChildrenWithText(backgroundColor: "#008800", text: "Zup"), makeBeagleComponentChildrenWithText(backgroundColor: "#0000AA", text: "IT!")])
        XCTAssertEqual(result, expected)
    }
}


extension RemoteBeagleTests {
    func makeBeagleComponentChildrenWithText(backgroundColor: String, text: String) -> Children {
        return Children(beagleComponent: "beagle:container", style: Style(backgroundColor: backgroundColor, padding: Style.Padding(all: Style.Padding.All(value: 20, type: "REAL")), margin: Style.Margin(vertical: Style.Margin.Vertical(value: 10, type: "REAL"))), text: nil, textColor: nil, children: [makeBeagleComponentText(text: text)])
    }
    
    func makeBeagleComponentChildrenBoxOnly(backgroundColor: String, paddingValue: Int, children: Children) -> Children {
        return Children(beagleComponent: "beagle:container", style: Style(backgroundColor: backgroundColor, padding: Style.Padding(all: Style.Padding.All(value: paddingValue, type: "REAL")), margin: nil), text: nil, textColor: nil, children: [children])
    }
    
    func makeBeagleComponentText(text: String) -> Children {
        return Children(beagleComponent: "beagle:text", style: nil, text: text, textColor: "#FFFFFF", children: nil)
    }
}
