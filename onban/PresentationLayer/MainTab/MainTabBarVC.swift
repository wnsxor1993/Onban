//
//  MainTabBarVC.swift
//  onban
//
//  Created by Zeto on 2022/10/28.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    weak var coordinatorDelegate: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTabBar()
    }
}

private extension MainTabBarVC {
    
    func configureTabBar() {
        tabBar.backgroundColor = .lightGray
    }
}
