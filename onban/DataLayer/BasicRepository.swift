//
//  BasicRepository.swift
//  onban
//
//  Created by Zeto on 2022/11/01.
//

import Foundation
import RxSwift

protocol BasicRepository {
    
    associatedtype DTO
    var networkService: NetworkProvider { get }
    
    func requestDTO(kind: OnbanService, with disposeBag: DisposeBag) -> Observable<DTO>
}
