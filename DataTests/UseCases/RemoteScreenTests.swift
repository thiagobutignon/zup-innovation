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
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
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
