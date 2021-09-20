# zup-innovation

Desafio resolvido utilizando ServerDrivenUI com Clean Architecture, seguindo os princípios do SOLID, KISS, YAGNI, DRY e TDD.

Os JSON's estão disponíveis em:
https://gist.github.com/thiagobutignon/0b26cb0e15c0158391d35a8a02810959

## Resolução do JSON Boxed-text.json
![image](https://user-images.githubusercontent.com/8093605/133960731-a11c79c2-053c-4485-8d41-4f99e62d8ad5.png)


## Resolução do JSON Multi-boxed.json
![image](https://user-images.githubusercontent.com/8093605/133960795-600a65b6-2945-4b96-96bd-a08666f71e73.png)

Para alterar entre os JSON, gentileza acessar o arquivo: `SceneDelegate.swift` na pasta Main e alterar as seguintes linhas:

```swift
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
```

