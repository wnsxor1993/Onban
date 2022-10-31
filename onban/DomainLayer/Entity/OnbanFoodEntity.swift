//
//  OnbanFoodEntity.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation

struct OnbanFoodEntity: Equatable {
    
    let detailHash: String
    let image: Data
    let title, bodyDescription: String
    let nPrice: String
    let sPrice: String?
    let badge: [String]?
}
