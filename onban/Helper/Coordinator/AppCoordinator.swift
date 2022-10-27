//
//  AppCoordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let window: UIWindow?
    
    init(_ window: UIWindow?) {
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    func start() {
        let tabBar = setTabBarController()
        self.window?.rootViewController = tabBar
    }
}

private extension AppCoordinator {
    
    func setTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let firstItem = UITabBarItem(title: "Main", image: nil, tag: 0)
        let secondItem = UITabBarItem(title: "Soup", image: nil, tag: 1)
        let thirdItem = UITabBarItem(title: "Side", image: nil, tag: 2)
        
        let firstCoordinator = FirstSectionCoordinator()
        firstCoordinator.parentCoordinator = self
        self.childCoordinators.append(firstCoordinator)
        
        let firstVC = firstCoordinator.startPush()
        firstVC.tabBarItem = firstItem
        
        let secondCoordinator = SecondSectionCoordinator()
        secondCoordinator.parentCoordinator = self
        self.childCoordinators.append(secondCoordinator)
        
        let secondVC = secondCoordinator.startPush()
        secondVC.tabBarItem = secondItem
        
        let thirdCoordinator = ThirdSectionCoordinator()
        thirdCoordinator.parentCoordinator = self
        self.childCoordinators.append(thirdCoordinator)
        
        let thirdVC = thirdCoordinator.startPush()
        thirdVC.tabBarItem = thirdItem
        
        tabBarController.viewControllers = [firstVC, secondVC, thirdVC]
        
        return tabBarController
    }
}
