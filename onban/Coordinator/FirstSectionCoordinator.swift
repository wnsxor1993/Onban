//
//  MainCoordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

class FirstSectionCoordinator: Coordinator, DetailNavigateDelegate {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(_ navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let mainRepository: BasicRepository = ViewDefaultMainRepository(serviceKind: .mainFoodFetch)
        let mainUsecase: ViewMainUsecase = ViewDefaultMainUsecase(repository: mainRepository)
        let mainVM = MainViewModel(usecase: mainUsecase)
        let mainVC = MainViewController(viewModel: mainVM)
        
        mainVC.deleage = self
        mainVC.detailNavigationDelegate = self
        mainVC.view.backgroundColor = .white
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(mainVC, animated: false)
    }
    
    func moveToDetailVC(with hash: String, entity: OnbanFoodEntity) {
        let detailRepository = ViewDefaultDetailRepository()
        let detailUsecase = ViewDefaultDetailUsecase(repository: detailRepository)
        let detailVM = DetailViewModel(queryHash: hash, usecase: detailUsecase)
        let detailVC = DetailViewController(detailVM: detailVM, foodEntity: entity)
        
        self.navigationController.pushViewController(detailVC, animated: true)
    }
}
