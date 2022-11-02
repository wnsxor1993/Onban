//
//  UIImage +.swift
//  onban
//
//  Created by Zeto on 2022/11/02.
//

import UIKit

extension UIImageView {
    
    func load(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }
    }
}
