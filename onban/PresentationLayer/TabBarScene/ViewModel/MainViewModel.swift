//
//  LoginViewModel.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import RxSwift
import RxCocoa

final class MainViewModel {
    
    struct Input {
        let defaultShowingDataEvent: Observable<Bool>
    }
    
    struct Output {
        let onbanFoodData = PublishSubject<[OnbanFoodEntity]>()
    }
    
    private let usecase: ViewMainUsecase
    private let output = Output()
    
    init(usecase: ViewMainUsecase) {
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

private extension MainViewModel {
    
    func configureBindingWithUsecase(disposeBag: DisposeBag) {
        self.usecase.foodsEntity
            .bind(to: output.onbanFoodData)
            .disposed(by: disposeBag)
    }
}
