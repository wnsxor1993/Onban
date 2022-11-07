//
//  ViewDefaultDetailRepository.swift
//  onban
//
//  Created by Zeto on 2022/11/07.
//

import RxSwift
import Moya

final class ViewDefaultDetailRepository: ViewDetailRepository {

    var networkService = NetworkProvider.shared
    private var serviceKind: OnbanService?
    
    func setQuery(with hash: String) {
        self.serviceKind = .foodDetailFetch(foodID: hash)
    }

    func requestDTO<T>(with disposeBag: DisposeBag) -> Observable<T> where T: Codable {

        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self, let serviceKind = self.serviceKind else {
                observer.onError(NetworkError.nonSelfError)

                return Disposables.create()
            }

            self.networkService.request(with: serviceKind)
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
