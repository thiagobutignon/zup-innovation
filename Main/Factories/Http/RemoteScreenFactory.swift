//
//  RemoteScreenFactory.swift
//  Main
//
//  Created by Thiago B Claramunt on 19/09/21.
//

import Foundation
import Data
import Domain

func makeRemoteScreenMultipleBoxes() -> Screen {
    return makeRemoteScreenWith(httpClient: makeAlamofireAdapter(), url: makeApiUrlForMultipleBoxes())
}

func makeRemoteScreenBoxedText() -> Screen {
    return makeRemoteScreenWith(httpClient: makeAlamofireAdapter(), url: makeApiUrlBoxedText())
}

func makeRemoteScreenWith(httpClient: HttpClient, url: URL) -> Screen {
    let remoteScreen = RemoteScreen(url: url, httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteScreen)
}
