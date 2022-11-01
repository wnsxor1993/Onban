//
//  MainTabBarVC.swift
//  onban
//
//  Created by Zeto on 2022/10/28.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    weak var coordinatorDelegate: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTabBar()
    }
}

private extension MainTabBarViewController {
    
    func configureTabBar() {
        tabBar.backgroundColor = .lightGray
    }
}
