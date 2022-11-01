//
//  NetworkProvider.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation
import Moya

final class NetworkProvider {
    
    static let shared = NetworkProvider()
    
    private let service = MoyaProvider<OnbanService>()
    private var result: Result<Response, MoyaError>?
    
    private init() { }
    
    func request(with section: OnbanService) -> Result<Response, MoyaError>? {
        switch section {
        case .mainFoodFetch:
            service.request(.mainFoodFetch) { result in
                self.result = result
            }
            
        case .soupFoodFetch:
            service.request(.soupFoodFetch) { result in
                self.result = result
            }
            
        case .sideFoodFetch:
            service.request(.sideFoodFetch) { result in
                self.result = result
            }
            
        case .foodDetailFetch(let foodID):
            service.request(.foodDetailFetch(foodID: foodID)) { result in
                self.result = result
            }
        }
        
        return self.result
    }
}
