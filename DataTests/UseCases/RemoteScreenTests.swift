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
}
