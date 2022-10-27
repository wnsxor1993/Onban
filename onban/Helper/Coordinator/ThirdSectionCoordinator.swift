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
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let sideVC = SideViewController()
        sideVC.deleage = self
        sideVC.view.backgroundColor = .white
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.setViewControllers([sideVC], animated: false)
        
        return self.navigationController
    }
}

