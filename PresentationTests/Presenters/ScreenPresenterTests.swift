//
//  ScreenPresenterTests.swift
//  PresentationTests
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import XCTest
import Presentation
import Domain

class ScreenPresenterTests: XCTestCase {
    func test_show_screen_should_show_generic_error_message_if_screen_fails() {
        
        let(sut, _, alertViewSpy, screenSpy, _) = makeSut()
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Você está sem conexão, tente novamente mais tarde"))
            exp.fulfill()
        }
        sut.show(viewModel: makeDisplayScreenViewModelBoxedTextJSON())
        screenSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    

    func test_show_screen_should_show_success_message_if_screen_succeds() {
        let(sut, displayScreenViewSpy, _, screenSpy, _) = makeSut()
        let exp = expectation(description: "waiting")
        displayScreenViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, DisplayScreenViewModel(data: makeJSONBoxedText()))
            exp.fulfill()
        }
        sut.show(viewModel: makeDisplayScreenViewModelBoxedTextJSON())
        screenSpy.completeWithScreen(makeJSONBoxedText())
        wait(for: [exp], timeout: 1)
    }

    func test_show_screen_should_show_loading_before_and_after_screen() {
        let(sut, _, _, screenSpy, loadingViewSpy) = makeSut()
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.show(viewModel: makeDisplayScreenViewModelBoxedTextJSON())
        wait(for: [exp], timeout: 1)
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        screenSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
}

typealias SutScreenPresenterType = (sut: ScreenPresenter, displayScreenViewSpy: DisplayScreenViewSpy, alertViewSpy: AlertViewSpy, screenSpy: ScreenSpy, loadingViewSpy: LoadingViewSpy)

extension ScreenPresenterTests {
    func makeSut(displayScreenView: DisplayScreenViewSpy = DisplayScreenViewSpy(), alertView: AlertViewSpy = AlertViewSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), screen: ScreenSpy = ScreenSpy(), file: StaticString = #file, line: UInt = #line) -> SutScreenPresenterType {
        let sut = ScreenPresenter(displayScreenView: displayScreenView, alertView: alertView, loadingView: loadingView, screen: screen)
        checkMemoryLeak(for: sut, file: file, line: line)
        return (sut, displayScreenView, alertView, screen, loadingView)
    }
}
