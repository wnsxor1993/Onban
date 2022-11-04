//
//  DetailTextQuantityView.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit
import Then
import SnapKit
import RxCocoa

final class DetailTextQuantityView: UIView {
    
    private var quantityTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .lightGray
        $0.text = "수량"
    }
    
    private var quantityStepper = UIStepper().then {
        $0.stepValue = 1
        $0.minimumValue = 1
        $0.maximumValue = 15
    }
    
    private lazy var quantityCountLabel = UILabel().then {
        $0.sizeToFit()
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.text = "\(Int(quantityStepper.value))"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStepperValueDriver() -> Driver<Int> {
        
        return quantityStepper.rx.value
            .map { Int($0) }
            .asDriver(onErrorJustReturn: 1)
    }
}

private extension DetailTextQuantityView {
    
    func configureLayouts() {
        self.addSubviews(quantityTitleLabel, quantityStepper, quantityCountLabel)
        
        quantityTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
        
        quantityStepper.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(28)
        }
        
        quantityCountLabel.snp.makeConstraints { make in
            make.trailing.equalTo(quantityStepper.snp.leading).offset(-24)
            make.centerY.equalToSuperview()
        }
    }
}

