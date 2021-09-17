//
//  IntegrationTests.swift
//  IntegrationTests
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import XCTest
import Domain
import Data
import Infra

class ScreenIntegrationTests: XCTestCase {
    func test_remote_screen_boxed_text_json_success() {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://gist.githubusercontent.com/thiagobutignon/0b26cb0e15c0158391d35a8a02810959/raw/d985c2b7d859d6b554e3ed524a19377a4d8d7ccb/boxed-text.json")!
        let sut = RemoteScreen(url: url, httpClient: alamofireAdapter)
        let exp = expectation(description: "waiting")
        sut.performs { result in
            switch result {
                case .failure:
                    XCTFail("Expected success, got \(result) instead")
                default:
                    dump(result)
                    XCTAssertNotNil(result)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func test_remote_screen_multiple_boxes_json_success() {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://gist.githubusercontent.com/thiagobutignon/0b26cb0e15c0158391d35a8a02810959/raw/d985c2b7d859d6b554e3ed524a19377a4d8d7ccb/multiple-boxes.json")!
        let sut = RemoteScreen(url: url, httpClient: alamofireAdapter)
        let exp = expectation(description: "waiting")
        sut.performs { result in
            switch result {
                case .failure:
                    XCTFail("Expected success, got \(result) instead")
                default:
                    dump(result)
                    XCTAssertNotNil(result)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
}
