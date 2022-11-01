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
    
    init(_ navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let mainRepository: ViewMainRepository = ViewDefaultMainRepository()
        let mainUsecase: ViewMainUsecase = ViewDefaultMainUsecase(repository: mainRepository)
        let mainVM = MainViewModel(usecase: mainUsecase)
        let mainVC = MainViewController(viewModel: mainVM)
        
        mainVC.deleage = self
        mainVC.view.backgroundColor = .white
        mainVC.tabBarItem = UITabBarItem(title: "Main", image: nil, tag: 0)
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(mainVC, animated: false)
    }
}
