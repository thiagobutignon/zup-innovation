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
//    func test_show_screen_should_call_screen_with_correct_values() {
//        let (sut, _, _, createUserSpy, _) = makeSut()
//        let viewModel = makeCreateUserRequestViewModel()
//        sut.show(viewModel: viewModel)
//        XCTAssertEqual(createUserSpy.user, makeCreateUserModelParams(name: viewModel.name!, document: viewModel.document!, email: viewModel.email!, phone: viewModel.phone!, password: viewModel.password!))
//    }
//    
//    func test_show_screen_should_show_generic_error_message_if_screen_fails() {
//        let(sut, alertViewSpy, _, createUserSpy, _) = makeSut()
//        let exp = expectation(description: "waiting")
//        alertViewSpy.observe { viewModel in
//            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
//            exp.fulfill()
//        }
//        sut.add(viewModel: makeCreateUserRequestViewModel())
//        createUserSpy.completeWithError(.unexpected)
//        wait(for: [exp], timeout: 1)
//    }
//    
//    func test_show_screen_should_show_has_an_screen_error_message_if_screen_completes_with_not_parsed() {
//        let (sut, alertViewSpy, _, createUserSpy, _) = makeSut()
//        let exp = expectation(description: "waiting")
//        alertViewSpy.observe { viewModel in
//            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "O usuário já existe, recupere sua senha."))
//            exp.fulfill()
//        }
//        sut.add(viewModel: makeCreateUserRequestViewModel())
//        createUserSpy.completeWithError(.emailInUse)
//        wait(for: [exp], timeout: 1)
//    }
//    
//    func test_show_screen_should_show_success_message_if_screen_succeds() {
//        let (sut, alertViewSpy, _, createUserSpy, _) = makeSut()
//        let exp = expectation(description: "waiting")
//        alertViewSpy.observe { viewModel in
//            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso."))
//            exp.fulfill()
//        }
//        sut.add(viewModel: makeCreateUserRequestViewModel())
//        createUserSpy.completeWithCreatedUser(makeCreateUserResponseModel())
//        wait(for: [exp], timeout: 1)
//    }
//    
//    func test_show_screen_should_show_loading_before_and_after_screen() {
//        let (sut, _, _, createUserSpy, loadingViewSpy) = makeSut()
//        let exp = expectation(description: "waiting")
//        loadingViewSpy.observe { viewModel in
//            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
//            exp.fulfill()
//        }
//        sut.add(viewModel: makeCreateUserRequestViewModel())
//        wait(for: [exp], timeout: 1)
//        let exp2 = expectation(description: "waiting")
//        loadingViewSpy.observe { viewModel in
//            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
//            exp2.fulfill()
//        }
//        createUserSpy.completeWithError(.unexpected)
//        wait(for: [exp2], timeout: 1)
//    }
}

typealias SutScreenPresenterType = (sut: ScreenPresenter, displayScreenViewSpy: DisplayScreenViewSpy, alertViewSpy: AlertViewSpy, screenSpy: ScreenSpy, loadingViewSpy: LoadingViewSpy)

extension ScreenPresenterTests {
    func makeSut(displayScreenView: DisplayScreenViewSpy = DisplayScreenViewSpy(), alertView: AlertViewSpy = AlertViewSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), screen: ScreenSpy = ScreenSpy(), file: StaticString = #file, line: UInt = #line) -> SutScreenPresenterType {
        let sut = ScreenPresenter(displayScreenView: displayScreenView, alertView: alertView, loadingView: loadingView, screen: screen)
        checkMemoryLeak(for: sut, file: file, line: line)
        return (sut, displayScreenView, alertView, screen, loadingView)
    }
}
