//
//  SecondSectionCoordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

class SecondSectionCoordinator: Coordinator, DetailNavigateDelegate {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(_ navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let soupRepository: BasicRepository = ViewDefaultMainRepository(serviceKind: .soupFoodFetch)
        let soupUsecase: ViewMainUsecase = ViewDefaultMainUsecase(repository: soupRepository)
        let soupVM = MainViewModel(usecase: soupUsecase)
        let soupVC = MainViewController(viewModel: soupVM)
        
        soupVC.deleage = self
        soupVC.detailNavigationDelegate = self
        soupVC.view.backgroundColor = .white
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(soupVC, animated: false)
    }
    
    func moveToDetailVC(with hash: String, entity: OnbanFoodEntity) {
        let detailRepository = ViewDefaultDetailRepository()
        let detailUsecase = ViewDefaultDetailUsecase(repository: detailRepository)
        let detailVM = DetailViewModel(queryHash: hash, usecase: detailUsecase)
        let detailVC = DetailViewController(detailVM: detailVM, foodEntity: entity)
        
        self.navigationController.pushViewController(detailVC, animated: true)
    }
}
