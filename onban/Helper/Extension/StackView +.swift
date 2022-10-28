//
//  StackView +.swift
//  onban
//
//  Created by Zeto on 2022/10/28.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
