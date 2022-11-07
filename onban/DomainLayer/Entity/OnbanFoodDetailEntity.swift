//
//  OnbanFoodDetailEntity.swift
//  onban
//
//  Created by Zeto on 2022/11/07.
//

import Foundation

struct OnbanFoodDetailEntity: Equatable {
    
    let thumbImageURLStrings: [String]
    let thumbImages: [Data]?
    let point, deliveryInfo, deliveryFee: String
    let detailImageURLStrings: [String]
    let detailImages: [Data]?
}
