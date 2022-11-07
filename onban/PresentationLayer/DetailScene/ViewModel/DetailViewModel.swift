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
        let defaultShowingDataEvent: Observable<String>
    }
    
    struct Output {
        let onbanFoodDetailData = PublishSubject<OnbanFoodDetailEntity>()
    }
    
    private let usecase: ViewDetailUsecase
    private let output = Output()
    
    init(usecase: ViewDetailUsecase) {
        self.usecase = usecase
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        self.configureBindingWithUsecase(disposeBag: disposeBag)
        
        input.defaultShowingDataEvent
            .subscribe({ [weak self] hash in
                guard let self = self, let hash = hash.element else { return }
                
                self.usecase.setRepositoryQuery(with: hash)
                self.usecase.execute(with: disposeBag)
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

private extension DetailViewModel {
    
    func configureBindingWithUsecase(disposeBag: DisposeBag) {
        self.usecase.foodDetailEntity
            .bind(to: output.onbanFoodDetailData)
            .disposed(by: disposeBag)
    }
}
