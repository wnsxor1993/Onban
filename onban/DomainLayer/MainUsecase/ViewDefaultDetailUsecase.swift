//
//  ViewDefaultDetailUsecase.swift
//  onban
//
//  Created by Zeto on 2022/11/07.
//

import RxSwift

final class ViewDefaultDetailUsecase: ViewDetailUsecase {
    
    private let repository: ViewDetailRepository
    let foodDetailEntity = PublishSubject<OnbanFoodDetailEntity>()
    
    init(repository: ViewDetailRepository) {
        self.repository = repository
    }
    
    func setRepositoryQuery(with hash: String) {
        repository.setQuery(with: hash)
    }
    
    func execute(with disposeBag: DisposeBag) {
        let dtoObserver: Observable<DetailData> = repository.requestDTO(with: disposeBag)
        
        dtoObserver
            .map { $0.data }
            .subscribe { [weak self] dto in
                self?.convertToEntity(from: dto)
            }
            .disposed(by: disposeBag)
    }
}

private extension ViewDefaultDetailUsecase {
    
    func convertToEntity(from detailDTO: OnbanDetailDTO) {
        var entity = OnbanFoodDetailEntity(thumbImageURLStrings: detailDTO.thumbImages, detailImageURLStrings: detailDTO.detailSection, point: detailDTO.point, deliveryInfo: detailDTO.deliveryInfo, deliveryFee: detailDTO.deliveryFee)
        
        guard let thumbImages = loadOrSaveChacheImages(with: entity.thumbImageURLStrings), let detailImages = loadOrSaveChacheImages(with: entity.thumbImageURLStrings) else {
            self.foodDetailEntity.onNext(entity)
            
            return
        }
        
        entity.thumbImages = thumbImages
        entity.detailImages = detailImages
        
        self.foodDetailEntity.onNext(entity)
    }
    
    func loadOrSaveChacheImages(with urlStrings: [String]) -> [Data]? {
        var cachedImages: [Data]? = nil
        
        urlStrings.forEach {
            guard let url = URL(string: $0), let imageData = FileCachedManager.loadData(validURL: url) else {
                FileCachedManager.saveData(urlString: $0)
                
                return
            }
            
            cachedImages?.append(imageData)
        }
        
        return cachedImages
    }
}

