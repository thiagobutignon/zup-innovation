//
//  ScreenSpy.swift
//  PresentationTests
//
//  Created by Thiago B Claramunt on 17/09/21.
//

import Foundation
import Domain

class ScreenSpy: Screen {
    var completion: ((Result<BeagleComponent, DomainError>) -> Void)?
    
    func performs(completion: @escaping (Screen.Result) -> Void) {
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithScreen(_ screen: BeagleComponent) {
        completion?(.success(screen))
    }
}

