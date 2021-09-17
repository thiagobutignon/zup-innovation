//
//  RemoteBeagleTests.swift
//  DataTests
//
//  Created by Thiago B Claramunt on 16/09/21.
//

import Foundation
import XCTest

struct StyleProperties: Codable, Equatable {
    let value: Int
    let type: String
}

struct BeagleComponent: Codable, Equatable {
    struct Style: Codable, Equatable {
        struct Padding: Codable, Equatable {
            typealias All = StyleProperties
            let all: All
        }
        
        struct Margin: Codable, Equatable {
            typealias Vertical = StyleProperties
            let vertical: Vertical
        }
        let backgroundColor: String
        let padding: Padding
        let margin: Margin?
    }
    
    struct Children: Codable, Equatable {
        let beagleComponent: String
        let style: Style?
        let text: String?
        let textColor: String?
        let children: [Children]?
        
        enum CodingKeys: String, CodingKey {
            case beagleComponent = "_beagleComponent_"
            case style
            case children
            case text
            case textColor
        }
    }
    
    
    let beagleComponent: String
    let style: Style?
    let children: [Children]
    
    
    enum CodingKeys: String, CodingKey {
        case beagleComponent = "_beagleComponent_"
        case style
        case children
    }
}





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
        let expected: BeagleComponent = BeagleComponent(beagleComponent: "beagle:container", style: BeagleComponent.Style(backgroundColor: "#FF0000", padding: BeagleComponent.Style.Padding(all: BeagleComponent.Style.Padding.All(value: 60, type: "REAL")), margin: nil), children: [makeBeagleComponentChildrenBoxOnly(backgroundColor: "#00FF00", paddingValue: 40, children: makeBeagleComponentChildrenBoxOnly(backgroundColor: "#0000FF", paddingValue: 20, children: makeBeagleComponentText(text: "Hello World!")))])
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
    func makeBeagleComponentChildrenWithText(backgroundColor: String, text: String) -> BeagleComponent.Children {
        return BeagleComponent.Children(beagleComponent: "beagle:container", style: BeagleComponent.Style(backgroundColor: backgroundColor, padding: BeagleComponent.Style.Padding(all: BeagleComponent.Style.Padding.All(value: 20, type: "REAL")), margin: BeagleComponent.Style.Margin(vertical: BeagleComponent.Style.Margin.Vertical(value: 10, type: "REAL"))), text: nil, textColor: nil, children: [makeBeagleComponentText(text: text)])
    }
    
    func makeBeagleComponentChildrenBoxOnly(backgroundColor: String, paddingValue: Int, children: BeagleComponent.Children) -> BeagleComponent.Children {
        return BeagleComponent.Children(beagleComponent: "beagle:container", style: BeagleComponent.Style(backgroundColor: backgroundColor, padding: BeagleComponent.Style.Padding(all: BeagleComponent.Style.Padding.All(value: paddingValue, type: "REAL")), margin: nil), text: nil, textColor: nil, children: [children])
    }
    
    func makeBeagleComponentText(text: String) -> BeagleComponent.Children {
        return BeagleComponent.Children(beagleComponent: "beagle:text", style: nil, text: text, textColor: "#FFFFFF", children: nil)
    }
}
