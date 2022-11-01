//
//  ViewDefaultMainRepository.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation
import RxSwift
import Moya

final class ViewDefaultMainRepository: BasicRepository {
    
    typealias DTO = OnbanFoodDTO
    let networkService = NetworkProvider.shared
    
    func requestDTO(kind: OnbanService, with disposeBag: DisposeBag) -> Observable<DTO> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self, let result = self.networkService.request(with: kind) else {
                observer.onError(NetworkError.serviceCaseError)
                
                return Disposables.create()
            }
            
            switch result {
            case .success(let response):
                guard response.statusCode == 200 else {
                    observer.onError(NetworkError.statusCodeError)
                    
                    return Disposables.create()
                }
                
                let data: Data = response.data
                let jsonConverter = JSONConverter<OnbanFoodDTO>()
                
                if let dto = jsonConverter.decode(data: data) {
                    observer.onNext(dto)
                    
                } else {
                    observer.onError(NetworkError.decodingError)
                    
                    return Disposables.create()
                }
                
            case .failure(let error):
                NSLog(error.localizedDescription)
                observer.onError(NetworkError.moyaNetworkError)
                
                return Disposables.create()
            }
            
            return Disposables.create()
        }
    }
}
