//
//  Coordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
