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
    
    func request(with section: OnbanService) -> Single<Data> {
        return Single<Data>.create { [weak self] observer -> Disposable in
            guard let self = self else {
                observer(.failure(NetworkError.nonSelfError))
                
                return Disposables.create()
            }
            
            self.service.request(section) { result in
                switch result {
                case .success(let response):
                    observer(.success(response.data))
                    
                case .failure(_):
                    observer(.failure(NetworkError.moyaNetworkError))
                }
            }
            
            return Disposables.create()
        }
    }
}
