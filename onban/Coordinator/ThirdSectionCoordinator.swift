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
        let sideRepository: BasicRepository = ViewDefaultMainRepository(serviceKind: .sideFoodFetch)
        let sideUsecase: ViewMainUsecase = ViewDefaultMainUsecase(repository: sideRepository)
        let sideVM = MainViewModel(usecase: sideUsecase)
        let sideVC = MainViewController(viewModel: sideVM)
        
        sideVC.deleage = self
        sideVC.view.backgroundColor = .white
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(sideVC, animated: false)
    }
}

