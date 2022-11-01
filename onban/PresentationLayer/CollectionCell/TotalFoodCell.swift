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
        $0.distribution = .fill
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    private var eventScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
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
    
    private var eventLabels = [UILabel]()
    
    static let reuseIdentifier = "TotalFoodCell"
    private var eventCount = 0
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.resetEventDataForReuse()
    }
    
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
    
    func checkNowEventBadgeCounts() -> Int {
        
        return self.eventCount
    }
}

private extension TotalFoodCell {
    
    func configureLayouts() {
        self.addSubviews(imageView, sectionStackView, amountStackView, eventScrollView)
        
        eventScrollView.addSubview(eventStackView)
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
        
        eventScrollView.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalToSuperview()
            make.top.equalTo(sectionStackView.snp.bottom).offset(12)
            make.height.equalTo(24)
        }
        
        eventStackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func configureLayouts(with width: CGFloat, for eventLabel: UILabel) {
        eventLabels.append(eventLabel)
        eventStackView.addArrangedSubview(eventLabel)
        
        eventLabel.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalToSuperview()
        }
    }
}

// MARK: For reuse cell (remove data)
private extension TotalFoodCell {
    
    // 이벤트 데이터는 다른 데이터와 달리 갈아끼우는 게 아닌, 추가 개념이라 reuse 시 데이터 혼선 발생
    func resetEventDataForReuse() {
        self.eventCount = 0
        
        eventLabels.forEach {
            $0.removeFromSuperview()
        }
        
        eventLabels.removeAll()
    }
}
