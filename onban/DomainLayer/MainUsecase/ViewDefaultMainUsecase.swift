//
//  ViewDefaultMainUsecase.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation
import RxSwift

final class ViewDefaultMainUsecase: ViewMainUsecase {
    
    private let repository: ViewMainRepository
    let foodsEntity = PublishSubject<[OnbanFoodEntity]>()
    
    init(repository: ViewMainRepository) {
        self.repository = repository
    }
    
    func execute(with disposeBag: DisposeBag) {
        repository.requestDTO(kind: .mainFoodFetch, with: disposeBag)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                
                switch event {
                case .next(let dto):
                    self.foodsEntity.onNext(self.convertToEntity(from: dto.body))
                    
                case .error(let error):
                    NSLog(error.localizedDescription)
                    
                case .completed:
                    NSLog("Main Food Data is fetced all - clear")
                }
            }
            .disposed(by: disposeBag)
    }
}

private extension ViewDefaultMainUsecase {
    
    func convertToEntity(from onbanDTO: [OnbanFoodDTO]) -> [OnbanFoodEntity] {
        var foodEntities = [OnbanFoodEntity]()
        
        onbanDTO.forEach {
            guard let url = URL(string: $0.image), let data = try? Data(contentsOf: url) else { return }
            
            let entity = OnbanFoodEntity(detailHash: $0.detailHash, image: data, title: $0.title, bodyDescription: $0.bodyDescription, nPrice: $0.nPrice, sPrice: $0.sPrice, badge: $0.badge)
            foodEntities.append(entity)
        }
        
        return foodEntities
    }
}
