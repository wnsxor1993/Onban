//
//  Coordinator.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var presenter: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}
