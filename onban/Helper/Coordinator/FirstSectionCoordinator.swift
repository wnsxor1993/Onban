//
//  MainCoordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

class FirstSectionCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let mainVC = MainViewController()
        mainVC.deleage = self
        mainVC.view.backgroundColor = .white
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.setViewControllers([mainVC], animated: false)
        
        return self.navigationController
    }
}
