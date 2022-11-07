//
//  DetailTextDescriptionView.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit
import Then
import SnapKit

final class DetailTextDescriptionView: UIView {
    
    private var sectionStackView = UIStackView().then {
        $0.spacing = 16
        $0.distribution = .fillEqually
        $0.axis = .vertical
    }
    
    private var descriptionStackView = UIStackView().then {
        $0.spacing = 16
        $0.distribution = .fillEqually
        $0.axis = .vertical
    }
    
    private let sectionTitles = ["적립금", "배송정보", "배송비"]
    private var descriptionLabels = [UILabel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureLayouts()
        self.configureLabels()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDescriptions(savedMoney: String, delivery: String, fee: String) {
        descriptionLabels[0].text = savedMoney
        descriptionLabels[1].text = delivery
        descriptionLabels[2].text = fee
    }
}

private extension DetailTextDescriptionView {
    
    func configureLayouts() {
        self.addSubviews(sectionStackView, descriptionStackView)
        
        sectionStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)
            make.width.equalTo(60)
        }
        
        descriptionStackView.snp.makeConstraints { make in
            make.leading.equalTo(sectionStackView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    func configureLabels() {
        for num in 0...2 {
            let label = UILabel().then {
                $0.font = .systemFont(ofSize: 14)
            }
            
            label.textColor = .lightGray
            label.text = sectionTitles[num]
            sectionStackView.addArrangedSubview(label)
        }
        
        for _ in 0...2 {
            let label = UILabel().then {
                $0.font = .systemFont(ofSize: 14)
            }
            
            label.textColor = .darkGray
            descriptionLabels.append(label)
            descriptionStackView.addArrangedSubview(label)
        }
    }
}
