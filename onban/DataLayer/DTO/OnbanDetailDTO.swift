//
//  OnbanDetailDTO.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import Foundation

struct DetailData: Codable {
    let hash: String
    let data: OnbanDetailDTO
}

// MARK: - DataClass
struct OnbanDetailDTO: Codable {
    let topImage: String
    let thumbImages: [String]
    let productDescription, point, deliveryInfo, deliveryFee: String
    let prices: [String]
    let detailSection: [String]

    enum CodingKeys: String, CodingKey {
        case topImage = "top_image"
        case thumbImages = "thumb_images"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices
        case detailSection = "detail_section"
    }
}
