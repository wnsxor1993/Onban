//
//  ViewDefaultDetailRepository.swift
//  onban
//
//  Created by Zeto on 2022/11/07.
//

import RxSwift
import Moya

final class ViewDefaultDetailRepository: BasicRepository {

    let networkService = NetworkProvider.shared
    let serviceKind: OnbanService
    
    init(serviceKind: OnbanService) {
        self.serviceKind = serviceKind
    }

    func requestDTO<T>(with disposeBag: DisposeBag) -> Observable<T> where T: Codable {

        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else {
                observer.onError(NetworkError.nonSelfError)

                return Disposables.create()
            }

            self.networkService.request(with: self.serviceKind)
                .map { JSONConverter<T>().decode(data: $0) }
                .subscribe { dto in
                    guard let dto = dto else {
                        observer.onError(NetworkError.decodingError)

                        return
                    }

                    observer.onNext(dto)

                } onFailure: { error in
                    NSLog(error.localizedDescription)
                    observer.onError(NetworkError.serviceCaseError)
                }
                .disposed(by: disposeBag)


            return Disposables.create()
        }
    }
}
