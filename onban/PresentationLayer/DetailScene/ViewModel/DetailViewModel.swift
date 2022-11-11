//
//  DetailViewModel.swift
//  onban
//
//  Created by Zeto on 2022/11/07.
//

import RxSwift
import RxCocoa

final class DetailViewModel {
    
    struct Input {
        let defaultShowingDataEvent: Observable<Bool>
    }
    
    struct Output {
        let onbanDetailData = PublishSubject<OnbanFoodDetailEntity>()
        let onbanDetailThumbnailImages = PublishSubject<[Data?]>()
        let onbanDetailDescripImages = PublishSubject<[Data?]>()
    }
    
    private let usecase: ViewDetailUsecase
    private let output = Output()
    
    init(usecase: ViewDetailUsecase) {
        self.usecase = usecase
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        self.configureBindingWithUsecase(disposeBag: disposeBag)
        
        input.defaultShowingDataEvent
            .subscribe({ [weak self] _ in
                guard let self = self else { return }
                
                self.usecase.execute(with: disposeBag)
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

private extension DetailViewModel {
    
    func configureBindingWithUsecase(disposeBag: DisposeBag) {
        self.usecase.foodDetailEntity
            .bind(to: output.onbanDetailData)
            .disposed(by: disposeBag)
        
        self.usecase.detailThumbImages
            .bind(to: output.onbanDetailThumbnailImages)
            .disposed(by: disposeBag)
        
        self.usecase.detailDescriptionImages
            .bind(to: output.onbanDetailDescripImages)
            .disposed(by: disposeBag)
    }
}
