//
//  SceneDelegate.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let networkManager = NetworkManager.shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        networkManager.request(endPoint: MusinsaEndPoint.main) { [weak self] (result: Result<ProductsEntity, NetworkError>) in
            switch result {
            case .success(let entity):
                let domain = entity.toDomain()
                let viewController = MainViewController()
                viewController.setDomain(with: domain)
                self?.window = UIWindow(windowScene: windowScene)
                self?.window?.backgroundColor = .systemBackground
                self?.window?.rootViewController = viewController
                self?.window?.makeKeyAndVisible()
            case .failure(let error):
                // MARK: - TODO Error Handling
                _ = error
            }
        }
    }
}
