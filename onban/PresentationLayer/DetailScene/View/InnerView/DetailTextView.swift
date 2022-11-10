//
//  DetailTextView.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit
import Then
import SnapKit
import RxCocoa

final class DetailTextView: UIView {
    
    private let lineViews = [LineView(), LineView(), LineView()]
    private var textMainView = DetailTextMainView()
    private var textDescriptionView = DetailTextDescriptionView()
    private var textQuantityView = DetailTextQuantityView()
    private var textTotalAmountView = DetailTextTotalAmountView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMainData(with model: OnbanFoodEntity) {
        textMainView.setDetailMainValues(title: model.title, description: model.bodyDescription, amount: model.sPrice, discount: model.nPrice)
        
        guard let badges = model.badge else {
            textMainView.hiddenEventLabel()
            textMainView.snp.remakeConstraints { make in
                make.leading.top.trailing.equalToSuperview()
                make.height.equalTo(170)
            }
            
            return
        }
        
        badges.forEach {
            textMainView.setEventLabel($0)
        }
    }
    
    func setDescriptionData(with point: String, deliveryInfo: String, deliveryFee: String) {
        textDescriptionView.setDescriptions(savedMoney: point, delivery: deliveryInfo, fee: deliveryFee)
    }
    
    func setQuantityStepDriver() -> Driver<Int> {
        
        return textQuantityView.setStepperValueDriver()
    }
    
    func setAmountButtonTouchDriver() -> Driver<Void> {
        
        return textTotalAmountView.setButtonTouchDriver()
    }
}

private extension DetailTextView {
    
    func configureLayouts() {
        self.addSubviews(textMainView, textDescriptionView, textQuantityView, textTotalAmountView)
        lineViews.forEach {
            self.addSubview($0)
        }
        
        textMainView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        textDescriptionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(textMainView.snp.bottom)
            make.height.equalTo(152)
        }
        
        textQuantityView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(textDescriptionView.snp.bottom)
            make.height.equalTo(76)
        }
        
        textTotalAmountView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(textQuantityView.snp.bottom)
            make.height.equalTo(194)
        }
        
        for (index, view) in lineViews.enumerated() {
            var topView = UIView()
            
            switch index {
            case 0:
                topView = textMainView
                
            case 1:
                topView = textDescriptionView
                
            case 2:
                topView = textQuantityView
                
            default:
                break
            }
            
            view.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.top.equalTo(topView.snp.bottom)
            }
        }
    }
}
