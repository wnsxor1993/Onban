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
        
    }
    
    struct Output {
        
    }
    
//    private let usecase: ViewMainUsecase
    private let output = Output()
    
//    init(usecase: ViewMainUsecase) {
//        self.usecase = usecase
//    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        
        return output
    }
}
