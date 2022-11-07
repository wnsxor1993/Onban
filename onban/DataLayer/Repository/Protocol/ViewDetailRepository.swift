//
//  ViewDetailRepository.swift
//  onban
//
//  Created by Zeto on 2022/11/07.
//

import RxSwift

protocol ViewDetailRepository: BasicRepository {
    
    func setQuery(with hash: String)
}
