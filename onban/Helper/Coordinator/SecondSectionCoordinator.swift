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
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let soupVC = SoupViewController()
        soupVC.deleage = self
        soupVC.view.backgroundColor = .white
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.setViewControllers([soupVC], animated: false)
        
        return self.navigationController
    }
}
