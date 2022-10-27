//
//  UIView +.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
