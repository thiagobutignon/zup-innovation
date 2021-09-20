//
//  ScreenViewControllerTests.swift
//  UITests
//
//  Created by Thiago B Claramunt on 19/09/21.
//

import XCTest
import UIKit
import Presentation
@testable import UI

class ScreenViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().screenView?.loadingIndicator.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_sut_implements_display_screen_view() {
        XCTAssertNotNil(makeSut() as DisplayScreenView)
    }
}

extension ScreenViewControllerTests {
    func makeSut(screenRequestSpy: ((ScreenRequest) -> Void)? = nil, file: StaticString = #file, line: UInt = #line) -> ScreenViewController {
        let sut = ScreenViewController()
        sut.loadScreen = screenRequestSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
