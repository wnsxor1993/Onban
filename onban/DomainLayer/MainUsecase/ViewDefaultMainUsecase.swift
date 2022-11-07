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
        let dtoObserver: Observable<MainData> = repository.requestDTO(with: disposeBag)
        
        dtoObserver
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
            guard let url = URL(string: $0.image) else { return }
            
            if let imageData = FileCachedManager.loadData(validURL: url) {
                let entity = OnbanFoodEntity(detailHash: $0.detailHash, imageURLString: $0.image, image: imageData, title: $0.title, bodyDescription: $0.bodyDescription, nPrice: $0.nPrice, sPrice: $0.sPrice, badge: $0.badge)
                foodEntities.append(entity)
                
            } else {
                FileCachedManager.saveData(urlString: $0.image)
                
                let entity = OnbanFoodEntity(detailHash: $0.detailHash, imageURLString: $0.image, image: nil, title: $0.title, bodyDescription: $0.bodyDescription, nPrice: $0.nPrice, sPrice: $0.sPrice, badge: $0.badge)
                foodEntities.append(entity)
            }
        }
        
        self.foodsEntity.onNext(foodEntities)
    }
}
