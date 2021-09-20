//
//  ApiUrlFactory.swift
//  Main
//
//  Created by Thiago B Claramunt on 19/09/21.
//

import Foundation

func makeApiUrlForMultipleBoxes() -> URL {
    return (URL(string: "https://gist.githubusercontent.com/thiagobutignon/0b26cb0e15c0158391d35a8a02810959/raw/d985c2b7d859d6b554e3ed524a19377a4d8d7ccb/multiple-boxes.json"))!
}

func makeApiUrlBoxedText() -> URL {
    return (URL(string: "https://gist.githubusercontent.com/thiagobutignon/0b26cb0e15c0158391d35a8a02810959/raw/d985c2b7d859d6b554e3ed524a19377a4d8d7ccb/boxed-text.json"))!
}
