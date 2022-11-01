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
    
    let networkService = NetworkProvider.shared
    let serviceKind: OnbanService
    
    init(serviceKind: OnbanService) {
        self.serviceKind = serviceKind
    }
    
    func requestDTO(with disposeBag: DisposeBag) -> Observable<MainData> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else {
                observer.onError(NetworkError.nonSelfError)
                
                return Disposables.create()
            }
            
            self.networkService.request(with: self.serviceKind)
                .subscribe { result in
                    switch result {
                    case .success(let response):
                        guard response.statusCode == 200 else {
                            observer.onError(NetworkError.statusCodeError)
                            
                            return
                        }
                        
                        let data: Data = response.data
                        let jsonConverter = JSONConverter<MainData>()
                        
                        if let dto = jsonConverter.decode(data: data) {
                            observer.onNext(dto)
                            
                        } else {
                            observer.onError(NetworkError.decodingError)
                            
                            return
                        }
                        
                    case .failure(let error):
                        NSLog(error.localizedDescription)
                        observer.onError(NetworkError.moyaNetworkError)
                        
                        return
                    }
                    
                } onFailure: { error in
                    NSLog(error.localizedDescription)
                    observer.onError(NetworkError.serviceCaseError)
                    
                }.disposed(by: disposeBag)
            
            
            return Disposables.create()
        }
    }
}
