//
//  DetailTextView.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit
import Then
import SnapKit

final class DetailTextView: UIView {
    
    private let lineViews = Array(repeating: LineView(), count: 3)
    private var textMainView = DetailTextMainView()
    private var textDescriptionView = DetailTextDescriptionView()
    private var textQuantityView = DetailTextQuantityView()
    private var textTotalAmountView = DetailTextTotalAmountView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: 상세 Entity 구현 시, 각 View의 데이터 제공 함수 호출하는 함수를 구현
}

private extension DetailTextView {
    
    func configureLayouts() {
        self.addSubviews(textMainView, textDescriptionView, textQuantityView, textTotalAmountView)
        lineViews.forEach {
            self.addSubview($0)
        }
        
        textMainView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(200)
        }
        
        lineViews[0].setLayout(topView: textMainView)
        
        textDescriptionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(lineViews[0].snp.bottom)
            make.height.equalTo(152)
        }
        
        lineViews[1].setLayout(topView: textDescriptionView)
        
        textQuantityView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(lineViews[1].snp.bottom)
            make.height.equalTo(76)
        }
        
        lineViews[2].setLayout(topView: textDescriptionView)
        
        textTotalAmountView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(lineViews[2].snp.bottom)
            make.height.equalTo(194)
        }
    }
}
