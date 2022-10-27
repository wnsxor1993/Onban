//
//  AppCoordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

class AppCoordinator: Coordinator, LoginCoordinatorDelegate {
    
    var presenter: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init(navigation: UINavigationController) {
        self.presenter = navigation
    }
    
    func start() {
        showLoginScene()
    }
    
    func didLogIn(_ coordinator: LoginCoordinator) {
        for (index, coor) in childCoordinators.enumerated() {
            guard coor === coordinator else { break }
            
            childCoordinators.remove(at: index)
            
            return
        }
        
        showMainScene()
    }
}

private extension AppCoordinator {
    
    func showLoginScene() {
        let loginCoorinator = LoginCoordinator(navi: self.presenter)
        self.childCoordinators.append(loginCoorinator)
        
        loginCoorinator.start()
    }
    
    func showMainScene() {
        
    }
}
