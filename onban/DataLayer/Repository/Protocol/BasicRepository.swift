//
//  BasicRepository.swift
//  onban
//
//  Created by Zeto on 2022/11/01.
//

import Foundation
import RxSwift

protocol BasicRepository {
    
    var networkService: NetworkProvider { get }
    
    func requestDTO<T: Codable>(with disposeBag: DisposeBag) -> Observable<T>
}
