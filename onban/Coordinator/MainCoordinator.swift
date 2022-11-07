//
//  MainCoordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/28.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(_ navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let tabVC = MainTabBarViewController()
        tabVC.coordinatorDelegate = self
        navigationController.pushViewController(tabVC, animated: false)
        
        self.configureTabBarCoordinators(with: tabVC)
    }
}

extension MainCoordinator {
    
    func configureTabBarCoordinators(with tabBarVC: UITabBarController) {
        self.configureFirstSectionCoordinator(with: tabBarVC)
        self.configureSecondSectionCoordinator(with: tabBarVC)
        self.configureThirdSectionCoordinator(with: tabBarVC)
    }
    
    func configureFirstSectionCoordinator(with tabBarVC: UITabBarController) {
        let mainNavigation = UINavigationController()
        
        let mainCoordinator = FirstSectionCoordinator(mainNavigation)
        self.childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
        tabBarVC.addChild(mainNavigation)
    }
    
    func configureSecondSectionCoordinator(with tabBarVC: UITabBarController) {
        let soupNavigation = UINavigationController()
        
        let soupCoordinator = SecondSectionCoordinator(soupNavigation)
        self.childCoordinators.append(soupCoordinator)
        soupCoordinator.start()
        tabBarVC.addChild(soupNavigation)
    }
    
    func configureThirdSectionCoordinator(with tabBarVC: UITabBarController) {
        let sideNavigation = UINavigationController()
        
        let sideCoordinator = ThirdSectionCoordinator(sideNavigation)
        self.childCoordinators.append(sideCoordinator)
        sideCoordinator.start()
        tabBarVC.addChild(sideNavigation)
    }
}
