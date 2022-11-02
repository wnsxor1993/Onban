//
//  ViewDefaultMainUsecase.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation
import RxSwift

final class ViewDefaultMainUsecase: ViewMainUsecase {
    
    private let repository: BasicRepository
    let foodsEntity = PublishSubject<[OnbanFoodEntity]>()
    
    init(repository: BasicRepository) {
        self.repository = repository
    }
    
    func execute(with disposeBag: DisposeBag) {
        repository.requestDTO(with: disposeBag)
            .map { $0.body }
            .subscribe { [weak self] dto in
                self?.convertToEntity(from: dto)
            }
            .disposed(by: disposeBag)
    }
}

private extension ViewDefaultMainUsecase {
    
    func convertToEntity(from onbanDTO: [OnbanFoodDTO]) {
        var foodEntities = [OnbanFoodEntity]()
        
        onbanDTO.forEach {
            let entity = OnbanFoodEntity(detailHash: $0.detailHash, image: $0.image, title: $0.title, bodyDescription: $0.bodyDescription, nPrice: $0.nPrice, sPrice: $0.sPrice, badge: $0.badge)
            foodEntities.append(entity)
        }
        
        self.foodsEntity.onNext(foodEntities)
    }
}
