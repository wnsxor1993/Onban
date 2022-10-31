//
//  OnbanFood.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation

struct MainData: Codable {
    let statusCode: Int
    let body: [OnbanFood]
}

// MARK: - Body
struct OnbanFood: Codable {
    let detailHash: String
    let image: String
    let description: String
    let deliveryType: [DeliveryType]
    let title, bodyDescription: String
    let nPrice: String?
    let sPrice: String
    let badge: [String]?

    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image
        case description = "alt"
        case deliveryType = "delivery_type"
        case title
        case bodyDescription = "description"
        case nPrice = "n_price"
        case sPrice = "s_price"
        case badge
    }
}

enum DeliveryType: String, Codable {
    case 새벽배송 = "새벽배송"
    case 전국택배 = "전국택배"
}
