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
        let expected: BeagleComponent = makeJSONBoxedText()
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
        let expected: BeagleComponent = makeJSONMultipleBoxes()
        XCTAssertEqual(result, expected)
    }
}
