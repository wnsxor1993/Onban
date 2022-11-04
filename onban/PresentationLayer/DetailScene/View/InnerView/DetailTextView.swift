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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailTextView {
    
    func configureLayouts() {
        self.addSubviews(textMainView, textDescriptionView)
        lineViews.forEach {
            self.addSubview($0)
        }
        
        textMainView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(200)
        }
        
        textDescriptionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(lineViews[0].snp.bottom)
            make.height.equalTo(152)
        }
    }
}
