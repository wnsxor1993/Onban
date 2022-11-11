//
//  OnbanFoodDetailEntity.swift
//  onban
//
//  Created by Zeto on 2022/11/07.
//

import Foundation

struct OnbanFoodDetailEntity: Equatable {
    
    let thumbImageURLStrings, detailImageURLStrings: [String]
    let point, deliveryInfo, deliveryFee: String
}
