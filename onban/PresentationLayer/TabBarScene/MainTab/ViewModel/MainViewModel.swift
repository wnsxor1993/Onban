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
        let defaultShowingDataEvent: Observable<Void>
    }
    
    struct CollectionViewOutput {
        let onbanFoodData = PublishSubject<[OnbanFood]>()
    }
    
    func transform(input: CollectionViewInput, disposeBag: DisposeBag) -> CollectionViewOutput {
        let output = CollectionViewOutput()
        
        input.defaultShowingDataEvent
            .subscribe({ [weak self] _ in
                
            })
            .disposed(by: disposeBag)
        
        return output
    }
}
