//
//  TotalFoodCell.swift
//  onban
//
//  Created by Zeto on 2022/10/28.
//

import UIKit

final class TotalFoodCell: UICollectionViewCell {
    
    private var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var sectionStackView = UIStackView().then {
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.axis = .vertical
        $0.spacing = 0
    }
    
    private var amountStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    private var eventStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    private var foodNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private var foodDescriptionLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    private var foodAmountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private var foodDiscountLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    static let reuseIdentifier = "TotalFoodCell"
    private var eventCount = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func setFoodValues(image: UIImage?, title: String, description: String, amount: String, discount: String?) {
        self.imageView.image = image
        self.foodNameLabel.text = title
        self.foodDescriptionLabel.text = description
        self.foodAmountLabel.text = amount
        
        guard let discount = discount else { return }
        
        self.foodDiscountLabel.attributedText = discount.strikeThrough()
    }
    
    func setEventLabel(_ event: String) {
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 12, weight: .semibold)
            $0.textColor = .white
            $0.textAlignment = .center
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 12
        }
        
        self.eventCount += 1
        
        switch event {
        case "런칭특가", "메인특가":
//            label.frame = CGRect(x: 0, y: 0, width: 77, height: 24)
            label.backgroundColor = .launchingEvent
            label.text = event
            self.configureLayouts(with: 77, for: label)
            
        case "이벤트특가":
//            label.frame = CGRect(x: 0, y: 0, width: 89, height: 24)
            label.backgroundColor = .eventAmount
            label.text = event
            self.configureLayouts(with: 89, for: label)
            
        default:
            return
        }
    }
    
    func checkNowEventBadgeCounts() -> Int {
        
        return self.eventCount
    }
}

private extension TotalFoodCell {
    
    func configureLayouts() {
        self.addSubviews(imageView, sectionStackView, amountStackView, eventStackView)
        
        amountStackView.addArrangedSubviews(foodAmountLabel, foodDiscountLabel)
        sectionStackView.addArrangedSubviews(foodNameLabel, foodDescriptionLabel, amountStackView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.height)
            make.top.bottom.left.equalToSuperview()
        }
        
        sectionStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalToSuperview()
            make.height.equalTo(72)
        }
        
        eventStackView.snp.makeConstraints { make in
            make.top.equalTo(sectionStackView.snp.bottom).offset(12)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    func configureLayouts(with width: CGFloat, for eventLabels: UILabel) {
        eventStackView.addArrangedSubview(eventLabels)
        
        eventLabels.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalToSuperview()
        }
    }
}
