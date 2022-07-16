//
//  SceneDelegate.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewController = MainViewController()
        let viewModel = MainViewModel()
        viewController.bind(with: viewModel)
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
