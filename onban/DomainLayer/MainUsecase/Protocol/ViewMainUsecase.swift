//
//  ViewMainUsecase.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation
import RxSwift

protocol ViewMainUsecase: BasicUsecase {
    
    var foodsEntity: PublishSubject<[OnbanFoodEntity]> { get }
}
