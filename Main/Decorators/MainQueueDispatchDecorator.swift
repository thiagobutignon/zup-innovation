//
//  MainQueueDispatchDecorator.swift
//  Main
//
//  Created by Thiago B Claramunt on 19/09/21.
//

import Foundation
import Domain

public final class MainQueueDispatchDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        completion()
    }
}

extension MainQueueDispatchDecorator: Screen where T: Screen {
    public func performs(completion: @escaping (Screen.Result) -> Void) {
        instance.performs { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}




