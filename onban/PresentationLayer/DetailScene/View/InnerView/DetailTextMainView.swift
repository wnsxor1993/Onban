//
//  DetailTextMainView.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit
import Then
import SnapKit

final class DetailTextMainView: UIView {
    
    private var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32, weight: .regular)
        $0.textAlignment = .left
    }
    
    private var descriptionLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 18)
        $0.sizeToFit()
    }
    
    private var amountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.sizeToFit()
    }
    
    private var discountLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.sizeToFit()
    }
    
    private var eventStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .fill
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDetailMainValues(title: String, description: String, amount: String, discount: String?) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.amountLabel.text = amount
        
        guard let discount = discount else { return }
        
        self.discountLabel.attributedText = discount.strikeThrough()
    }
    
    func hiddenEventLabel() {
        self.eventStackView.isHidden = true
    }
    
    func setEventLabel(_ event: String) {
        let eventLabel = EventLabel()
        eventStackView.addArrangedSubview(eventLabel)
        eventLabel.setLabelEvent(with: event)
    }
}

private extension DetailTextMainView {
    
    func configureLayouts() {
        self.addSubviews(titleLabel, descriptionLabel, amountLabel, discountLabel, eventStackView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.equalTo(descriptionLabel.snp.leading)
        }
        
        discountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(amountLabel.snp.bottom)
            make.leading.equalTo(amountLabel.snp.trailing).offset(8)
        }
        
        eventStackView.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(16)
            make.leading.equalTo(amountLabel)
            make.height.equalTo(24)
        }
    }
}
