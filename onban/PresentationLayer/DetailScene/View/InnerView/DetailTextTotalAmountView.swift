//
//  DetailTextTotalAmountView.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit
import Then
import SnapKit
import RxCocoa

final class DetailTextTotalAmountView: UIView {
    
    private var amountTitleLabel = UILabel().then {
        $0.text = "총 주문금액"
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .lightGray
        $0.sizeToFit()
    }
    
    private lazy var amountValueLabel = UILabel().then {
        $0.text = "0원"
        $0.textAlignment = .right
        $0.font = .systemFont(ofSize: 32, weight: .semibold)
    }
    
    private var orderButton = UIButton().then {
        $0.setTitle("주문하기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
        $0.backgroundColor = .orderButton
        $0.layer.cornerRadius = 20
    }
    
    private var defaultAmount = 0
    
    init(with amount: String) {
        super.init(frame: .init())
        
        self.amountValueLabel.text = amount
        self.changeStringToInt(amountString: amount)
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAmountValue(count: Int) {
        let amount = defaultAmount * count
        var amountString = String(amount)
        var amountIndex = 0
        
        guard amountString.count > 3 else {
            self.amountValueLabel.text = "\(amountString)원"
            
            return
        }
        
        amountIndex += (amountString.count - 3)
        
        let index = amountString.index(amountString.startIndex, offsetBy: amountIndex)
        amountString.insert(",", at: index)
        
        self.amountValueLabel.text = "\(amountString)원"
    }
    
    func setButtonTouchDriver() -> Driver<Void> {
        
        return orderButton.rx.tap
            .asDriver()
    }
}

private extension DetailTextTotalAmountView {
    
    func configureLayouts() {
        self.addSubviews(amountTitleLabel, amountValueLabel, orderButton)
        
        amountValueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        amountTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(amountValueLabel)
            make.leading.equalToSuperview().offset(100)
        }
        
        orderButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(amountValueLabel.snp.bottom).offset(24)
            make.height.equalTo(50)
        }
    }
    
    func changeStringToInt(amountString: String) {
        guard let value = Int(amountString.replacingOccurrences(of: "원", with: "").replacingOccurrences(of: ",", with: "")) else {
            return
        }
        
        self.defaultAmount = value
    }
}

