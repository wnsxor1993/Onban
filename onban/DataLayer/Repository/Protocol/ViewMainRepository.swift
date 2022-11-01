//
//  ViewMainRepository.swift
//  onban
//
//  Created by Zeto on 2022/11/01.
//

import Foundation
import RxSwift

protocol ViewMainRepository: BasicRepository {
    
    func requestDTO(kind: OnbanService, with disposeBag: DisposeBag) -> Observable<MainData>
}
