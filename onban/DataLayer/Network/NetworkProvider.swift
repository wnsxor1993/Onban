//
//  NetworkProvider.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation
import Moya
import RxSwift

final class NetworkProvider {
    
    static let shared = NetworkProvider()
    
    private let service = MoyaProvider<OnbanService>()
    
    private init() { }
    
    func request(with section: OnbanService) -> Single<Result<Response, MoyaError>> {
        return Single<Result<Response, MoyaError>>.create { [weak self] observer -> Disposable in
            guard let self = self else {
                observer(.failure(NetworkError.nonSelfError))
                
                return Disposables.create()
            }
            
            switch section {
            case .mainFoodFetch:
                self.service.request(.mainFoodFetch) { result in
                    observer(.success(result))
                }
                
            case .soupFoodFetch:
                self.service.request(.soupFoodFetch) { result in
                    observer(.success(result))
                }
                
            case .sideFoodFetch:
                self.service.request(.sideFoodFetch) { result in
                    observer(.success(result))
                }
                
            case .foodDetailFetch(let foodID):
                self.service.request(.foodDetailFetch(foodID: foodID)) { result in
                    observer(.success(result))
                }
            }
            
            return Disposables.create()
        }
    }
}
