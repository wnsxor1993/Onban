//
//  ThirdSectionCoordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

class ThirdSectionCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(_ navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let sideVC = SideViewController()
        sideVC.deleage = self
        sideVC.view.backgroundColor = .green
        sideVC.tabBarItem = UITabBarItem(title: "Side", image: nil, tag: 2)
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(sideVC, animated: false)
    }
}

