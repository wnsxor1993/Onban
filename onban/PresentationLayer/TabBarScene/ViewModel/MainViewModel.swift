//
//  LoginViewModel.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel {
    
    struct CollectionViewInput {
        let defaultShowingDataEvent: Observable<Bool>
    }
    
    struct CollectionViewOutput {
        let onbanFoodData = PublishSubject<[OnbanFoodEntity]>()
    }
    
    private let usecase: ViewMainUsecase
    private let output = CollectionViewOutput()
    
    init(usecase: ViewMainUsecase) {
        self.usecase = usecase
    }
    
    func transform(input: CollectionViewInput, disposeBag: DisposeBag) -> CollectionViewOutput {
        self.configureBindingWithUsecase(disposeBag: disposeBag)
        
        input.defaultShowingDataEvent
            .subscribe({ [weak self] isLoaded in
                guard let self = self else { return }
                
                self.usecase.execute(with: disposeBag)
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

private extension MainViewModel {
    
    func configureBindingWithUsecase(disposeBag: DisposeBag) {
        self.usecase.foodsEntity
            .bind(to: output.onbanFoodData)
            .disposed(by: disposeBag)
    }
}
