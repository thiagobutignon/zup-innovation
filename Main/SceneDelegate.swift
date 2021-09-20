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
//        Gentileza comentar a linha 17 para rodar visualizar o segundo JSON e descomentar a linha 19
        let screenViewController = makeScreenBoxedText()
//        Gentileza alterar essa linha para ver o segundo JSON
//        let screenViewController = makeScreenMultipleBoxes()
        window?.rootViewController = screenViewController
        window?.makeKeyAndVisible()
    }
}

