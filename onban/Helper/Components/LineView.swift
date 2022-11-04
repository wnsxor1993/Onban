//
//  LineView.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit
import SnapKit

final class LineView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureSettings()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(topView: UIView) {
        self.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(topView.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

private extension LineView {
    
    func configureSettings() {
        self.backgroundColor = .darkGray
    }
}

