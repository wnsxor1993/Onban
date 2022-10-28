//
//  AppCoordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(_ navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let mainCoor = MainCoordinator(self.navigationController)
        childCoordinators.append(mainCoor)
        
        mainCoor.start()
    }
}
