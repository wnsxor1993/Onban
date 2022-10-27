//
//  SceneDelegate.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        let navi = UINavigationController()
        self.window?.rootViewController = navi
        
        let coordinator = AppCoordinator(navigation: navi)
        coordinator.start()
        
        self.window?.makeKeyAndVisible()
    }
}

