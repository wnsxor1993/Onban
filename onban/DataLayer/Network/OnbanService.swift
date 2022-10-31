//
//  OnbanService.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation
import Moya

enum OnbanService {
    case mainFoodFetch
    case soupFoodFetch
    case sideFoodFetch
    case foodDetailFetch(foodID: String)
}

extension OnbanService: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.codesquad.kr/onban/") else {
            fatalError("This is not valid URL")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .mainFoodFetch:
            return "main"
            
        case .soupFoodFetch:
            return "soup"
            
        case .sideFoodFetch:
            return "side"
            
        case .foodDetailFetch(foodID: let foodID):
            return "detail/\(foodID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .mainFoodFetch, .soupFoodFetch, .sideFoodFetch, .foodDetailFetch(foodID: _):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .mainFoodFetch, .soupFoodFetch, .sideFoodFetch, .foodDetailFetch(foodID: _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        
        return ["Content-Type": "application/json"]
    }
}
