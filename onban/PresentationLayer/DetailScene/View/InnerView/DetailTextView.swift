//
//  DetailTextView.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit

final class DetailTextView: UIView {
    
    private var textMainView = DetailTextMainView()
    
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
        self.addSubviews(textMainView)
        
        textMainView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}
