//
//  SceneDelegate.swift
//  Main
//
//  Created by Thiago B Claramunt on 19/09/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windownScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windownScene)
        let screenViewController = makeScreenMultipleBoxes()
        window?.rootViewController = screenViewController
        window?.makeKeyAndVisible()
    }
}

