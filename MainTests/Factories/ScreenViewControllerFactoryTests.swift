//
//  ScreenViewControllerFactoryTests.swift
//  MainTests
//
//  Created by Thiago B Claramunt on 19/09/21.
//

import XCTest
import Main
import UI
import Domain
import Presentation

class ScreenControllerFactory: XCTestCase {
    func test_background_request_should_complete_on_main_thread() {
        let (sut, screenSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.show(viewModel: DisplayScreenViewModel(data: BeagleComponent(beagleComponent: "any_beagleComponent", style: Style(backgroundColor: "any_backgroundColor", padding: Style.Padding(all: Style.Padding.All(value: 0, type: "any_type")), margin: nil), children: [Children(beagleComponent: "any_beagleComponent", style: nil, text: "any_text", textColor: "any_textColor", children: nil)])))
        let exp = expectation(description: "waiting")
        DispatchQueue.global().async {
            screenSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

typealias SutTypesScreenControllerFactory = (sut: ScreenViewController, screen: ScreenSpy)

extension ScreenControllerFactory {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> SutTypesScreenControllerFactory {
        let screenSpy = ScreenSpy()
        let sut = makeScreenViewControllerWith(screen: screenSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: screenSpy, file: file, line: line)
        return (sut, screenSpy)
    }
}

