//
//  LoginCoordinatorDelegate.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import Foundation

protocol LoginCoordinatorDelegate: AnyObject {
    
    func didLogIn(_ coordinator: LoginCoordinator)
}
