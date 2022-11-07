//
//  ViewDetailUsecase.swift
//  onban
//
//  Created by Zeto on 2022/11/07.
//

import RxSwift

protocol ViewDetailUsecase: BasicUsecase {
    
    var foodDetailEntity: PublishSubject<OnbanFoodDetailEntity> { get }
    
    func setRepositoryQuery(with hash: String)
}
