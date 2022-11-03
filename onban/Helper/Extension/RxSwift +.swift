//
//  RxSwift +.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import RxSwift

extension RxSwift.Reactive where Base: UIViewController {
    
    public var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }
}
