//
//  BasciUsecase.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation
import RxSwift

protocol BasicUsecase {
    
    func execute(with disposeBag: DisposeBag)
}
