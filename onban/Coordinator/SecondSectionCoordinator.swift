//
//  SecondSectionCoordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

class SecondSectionCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(_ navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let soupVC = SoupViewController()
        soupVC.deleage = self
        soupVC.view.backgroundColor = .blue
        soupVC.tabBarItem = UITabBarItem(title: "Soup", image: nil, tag: 1)
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(soupVC, animated: false)
    }
}
