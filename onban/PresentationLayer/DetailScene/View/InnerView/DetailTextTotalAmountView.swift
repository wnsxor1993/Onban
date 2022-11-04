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
        $0.font = .systemFont(ofSize: 32, weight: .semibold)
    }
    
    private var orderButton = UIButton().then {
        $0.setTitle("주문하기", for: .normal)
        $0.setTitleColor(UIColor.blue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10
    }
    
    private var defaultAmount = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureLayouts()
    }
    
    convenience init(amount: String) {
        self.init()
        
        self.amountValueLabel.text = amount
        self.changeStringToInt(amountString: amount)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAmountValue(count: Int) {
        let amount = defaultAmount * count
        var amountString = String(amount)
        
        let index = amountString.index(amountString.startIndex, offsetBy: 2)
        amountString.insert(",", at: index)
        
        self.amountValueLabel.text = amountString
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
            make.top.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(132)
            make.height.equalTo(48)
        }
        
        amountTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(amountValueLabel)
            make.trailing.equalTo(amountValueLabel.snp.leading).offset(-24)
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

