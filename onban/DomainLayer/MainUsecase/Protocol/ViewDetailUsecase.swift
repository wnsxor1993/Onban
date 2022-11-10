//
//  ViewDetailUsecase.swift
//  onban
//
//  Created by Zeto on 2022/11/07.
//

import RxSwift

protocol ViewDetailUsecase: BasicUsecase {
    
    var foodDetailEntity: PublishSubject<OnbanFoodDetailEntity> { get }
    var detailThumbImages: PublishSubject<[Data?]> { get }
    var detailDescriptionImages: PublishSubject<[Data?]> { get }
    
    func setRepositoryQuery(with hash: String)
}
