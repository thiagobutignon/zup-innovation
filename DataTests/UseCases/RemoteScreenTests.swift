//
//  RemoteScreenTests.swift
//  DataTests
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import XCTest
import Domain
import Data

class RemoteScreenTests: XCTestCase {
    func test_perfoms_should_call_httpclient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) =  makeSut(url: url)
        sut.performs { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_performs_should_call_httpClient_with_no_data() {
        let (sut, httpClientSpy) = makeSut()
        sut.performs { _ in }
        XCTAssertEqual(httpClientSpy.data, nil)
    }
    
    func test_performs_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.badRequest), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    func test_performs_should_complete_with_badRequest_if_client_complete_with_badRequest() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.badRequest), when: {
            httpClientSpy.completeWithError(.badRequest)
        })
    }
    
    func test_performs_should_complete_with_unexpected_error_if_client_complete_with_serverError() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.serverError)
        })
    }
    
    func test_performs_should_complete_with_beagle_component_boxed_text_json_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let boxedTextJson: BeagleComponent = makeJSONBoxedText()
        expect(sut, completeWith: .success(boxedTextJson), when: {
            httpClientSpy.completeWithData(boxedTextJson.toData()!)
        })
    }
    
    func test_performs_should_complete_with_beagle_component_multiple_boxes_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let multipleBoxesJson: BeagleComponent = makeJSONMultipleBoxes()
        expect(sut, completeWith: .success(multipleBoxesJson), when: {
            httpClientSpy.completeWithData(multipleBoxesJson.toData()!)
        })
    }
    
    func test_performs_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unableToParsing), when: {
            httpClientSpy.completeWithData(makeInvalidData())
        })
    }

    func test_performs_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteScreen? = RemoteScreen(url: makeUrl(), httpClient: httpClientSpy)
        var result: Result<BeagleComponent, DomainError>?
        sut?.performs(completion: { result = $0 })
        sut = nil
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
    }
}

typealias SutRemoteScreenType = (sut: RemoteScreen, httpClientSpy: HttpClientSpy)

extension RemoteScreenTests {
    func makeSut(url: URL = URL(string: faker.internet.domainName())!, file: StaticString = #file, line: UInt = #line) -> SutRemoteScreenType {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteScreen(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteScreen, completeWith expectedResult: Screen.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.performs { receivedResult in
            switch (expectedResult, receivedResult) {
                case (.failure(let expectedError), .failure(let receivedError)):
                    XCTAssertEqual(expectedError, receivedError, file: file, line: line)
                case (.success(let expectedAccount), .success(let receivedAccount)):
                    XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
                default:
                    XCTFail("Expected \(expectedResult) error received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
