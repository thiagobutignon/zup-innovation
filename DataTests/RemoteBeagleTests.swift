//
//  RemoteBeagleTests.swift
//  DataTests
//
//  Created by Thiago B Claramunt on 16/09/21.
//

import Foundation
import XCTest

struct BeagleComponent: Codable, Equatable {
    struct Style: Codable, Equatable {
        struct Padding: Codable, Equatable {
            struct All: Codable, Equatable {
                let value: Int
                let type: String
            }
            let all: All
        }
        
        struct Margin: Codable, Equatable {
            struct Vertical: Codable, Equatable {
                let value: Int
                let type: String
            }
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
        let expected: BeagleComponent = BeagleComponent(beagleComponent: "beagle:container", style: BeagleComponent.Style(backgroundColor: "#FF0000", padding: BeagleComponent.Style.Padding(all: BeagleComponent.Style.Padding.All(value: 60, type: "REAL")), margin: nil), children: [BeagleComponent.Children(beagleComponent: "beagle:container", style: BeagleComponent.Style(backgroundColor: "#00FF00", padding: BeagleComponent.Style.Padding(all: BeagleComponent.Style.Padding.All(value: 40, type: "REAL")), margin: nil), text: nil, textColor: nil, children: [BeagleComponent.Children(beagleComponent: "beagle:container", style: BeagleComponent.Style(backgroundColor: "#0000FF", padding: BeagleComponent.Style.Padding(all: BeagleComponent.Style.Padding.All(value: 20, type: "REAL")), margin: nil), text: nil, textColor: nil, children: [BeagleComponent.Children(beagleComponent: "beagle:text", style: nil, text: "Hello World!", textColor: "#FFFFFF", children: nil)])])])
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
        let expected: BeagleComponent = BeagleComponent(beagleComponent: "beagle:container", style: nil, children: [makeBeagleComponentChildren(backgroundColor: "#AA0000", text: "Hello"), makeBeagleComponentChildren(backgroundColor: "#008800", text: "Zup"), makeBeagleComponentChildren(backgroundColor: "#0000AA", text: "IT!")])
        XCTAssertEqual(result, expected)
    }
}


extension RemoteBeagleTests {
    func makeBeagleComponentChildren(backgroundColor: String, text: String) -> BeagleComponent.Children {
        return BeagleComponent.Children(beagleComponent: "beagle:container", style: BeagleComponent.Style(backgroundColor: backgroundColor, padding: BeagleComponent.Style.Padding(all: BeagleComponent.Style.Padding.All(value: 20, type: "REAL")), margin: BeagleComponent.Style.Margin(vertical: BeagleComponent.Style.Margin.Vertical(value: 10, type: "REAL"))), text: nil, textColor: nil, children: [BeagleComponent.Children(beagleComponent: "beagle:text", style: nil, text: text, textColor: "#FFFFFF", children: nil)])
    }
}
