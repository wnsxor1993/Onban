//
//  DetailNavigate.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import Foundation

protocol DetailNavigateDelegate: AnyObject {
    
    func moveToDetailVC(with hash: String, entity: OnbanFoodEntity)
}
