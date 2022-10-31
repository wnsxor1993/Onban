//
//  ViewDefaultMainUsecase.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation
import RxSwift

final class ViewDefaultMainUsecase: ViewMainUsecase {
    
    let foodsEntity = PublishSubject<[OnbanFoodEntity]>()
    
    func execute() {
        // 임시 데이터
        guard let url = URL(string: "https://public.codesquad.kr/jk/storeapp/data/main/1155_ZIP_P_0081_T.jpg") else { return }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let entity = OnbanFoodEntity(detailHash: "ABCDE", image: data, title: "임시 데이터", bodyDescription: "뷰 확인을 위한 임시 데이터", nPrice: "15,000", sPrice: "11,500", badge: ["런칭특가", "메인특가", "이벤트특가"])
                let entities = Array(repeating: entity, count: 11)
                
                self.foodsEntity.onNext(entities)
                
            } catch {
                NSLog("Can not convert URL to Data")
            }
        }
    }
}
