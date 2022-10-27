//
//  LoginCoordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

class LoginCoordinator: Coordinator, LoginVCDelegate {
    
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    weak var coordinatorDelegate: LoginCoordinatorDelegate?
    
    init(navi: UINavigationController) {
        self.presenter = navi
    }
    
    func start() {
        let loginVC = LoginViewController()
        loginVC.coordinatorDelegate = self
        
        self.presenter.pushViewController(loginVC, animated: true)
    }
    
    func willLogIn() {
        self.coordinatorDelegate?.didLogIn(self)
    }
}
