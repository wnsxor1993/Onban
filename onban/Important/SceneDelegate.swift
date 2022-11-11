//
//  SceneDelegate.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        let naviController = UINavigationController()
        naviController.isNavigationBarHidden = true
        
        self.appCoordinator = AppCoordinator(naviController)
        self.appCoordinator?.start()
        
        self.window?.rootViewController = naviController
        self.window?.makeKeyAndVisible()
    }
}

