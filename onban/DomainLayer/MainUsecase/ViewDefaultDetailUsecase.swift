//
//  ViewDefaultDetailUsecase.swift
//  onban
//
//  Created by Zeto on 2022/11/07.
//

import RxSwift

final class ViewDefaultDetailUsecase: ViewDetailUsecase {
    
    private let repository: BasicRepository
    let foodDetailEntity = PublishSubject<OnbanFoodDetailEntity>()
    let detailThumbImages = PublishSubject<[Data?]>()
    let detailDescriptionImages = PublishSubject<[Data?]>()
    
    init(repository: BasicRepository) {
        self.repository = repository
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
        let entity = OnbanFoodDetailEntity(thumbImageURLStrings: detailDTO.thumbImages, detailImageURLStrings: detailDTO.detailSection, point: detailDTO.point, deliveryInfo: detailDTO.deliveryInfo, deliveryFee: detailDTO.deliveryFee)
        
        DispatchQueue.global().async {
            self.chacheThumbImages(with: detailDTO.thumbImages)
            self.chacheDescriptionImages(with: detailDTO.detailSection)
        }
        
        self.foodDetailEntity.onNext(entity)
    }
    
    func chacheThumbImages(with urlStrings: [String]) {
        var cachedImages = [Data?]()
        
        urlStrings.forEach {
            guard let url = URL(string: $0) else { return }
            
            if let imageData = FileCachedManager.loadData(validURL: url) {
                cachedImages.append(imageData)
                
            } else {
                FileCachedManager.saveData(urlString: $0)
                
                guard let data = try? Data(contentsOf: url) else {
                    cachedImages.append(nil)
                    
                    return
                }
                
                cachedImages.append(data)
            }
        }
        
        detailThumbImages.onNext(cachedImages)
    }
    
    func chacheDescriptionImages(with urlStrings: [String]) {
        var cachedImages = [Data?]()
        
        urlStrings.forEach {
            guard let url = URL(string: $0) else { return }
            
            if let imageData = FileCachedManager.loadData(validURL: url) {
                cachedImages.append(imageData)
                
            } else {
                FileCachedManager.saveData(urlString: $0)
                
                guard let data = try? Data(contentsOf: url) else {
                    cachedImages.append(nil)
                    
                    return
                }
                
                cachedImages.append(data)
            }
        }
        
        detailDescriptionImages.onNext(cachedImages)
    }
}

