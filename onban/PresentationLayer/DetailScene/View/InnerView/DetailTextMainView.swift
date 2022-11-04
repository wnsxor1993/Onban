//
//  DetailTextMainView.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit

final class DetailTextMainView: UIView {
    
    private var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32, weight: .regular)
        $0.textAlignment = .left
    }
    
    private var descriptionLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 18)
        $0.textAlignment = .left
    }
    
    private var amountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private var discountLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private var eventStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .fill
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        self.descriptionLabel.attributedText = discount.strikeThrough()
    }
    
    func setEventLabel(_ event: String) {
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 12, weight: .semibold)
            $0.textColor = .white
            $0.textAlignment = .center
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 12
        }

        switch event {
        case "런칭특가", "메인특가":
            label.backgroundColor = .launchingEvent
            label.text = event
            self.configureLayouts(with: 77, for: label)
            
        case "이벤트특가":
            label.backgroundColor = .eventAmount
            label.text = event
            self.configureLayouts(with: 89, for: label)
            
        default:
            return
        }
    }
}

private extension DetailTextMainView {
    
    func configureLayouts() {
        self.addSubviews(titleLabel, descriptionLabel, amountLabel, discountLabel, eventStackView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
            make.height.equalTo(24)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.equalTo(descriptionLabel)
            make.height.equalTo(24)
        }
        
        discountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(amountLabel.snp.centerY)
            make.leading.equalTo(amountLabel.snp.trailing).offset(8)
            make.height.equalTo(24)
        }
        
        eventStackView.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(16)
            make.leading.equalTo(amountLabel)
            make.height.equalTo(24)
        }
    }
    
    func configureLayouts(with width: CGFloat, for eventLabel: UILabel) {
        eventStackView.addArrangedSubview(eventLabel)
        
        eventLabel.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalToSuperview()
        }
    }
}
