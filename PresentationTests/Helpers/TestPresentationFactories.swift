//
//  TestPresentationFactories.swift
//  PresentationTests
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import Foundation
import Presentation
import Domain

func makeDisplayScreenViewModelBoxedTextJSON() -> ScreenRequest {
    let mock = makeJSONBoxedText()
    return ScreenRequest(beagleComponent: mock.beagleComponent, style: mock.style, children: mock.children)
}

func makeDisplayScreenViewModelMultipleBoxesJSON() -> ScreenRequest {
    let mock = makeJSONMultipleBoxes()
    return ScreenRequest(beagleComponent: mock.beagleComponent, style: mock.style, children: mock.children)
}
