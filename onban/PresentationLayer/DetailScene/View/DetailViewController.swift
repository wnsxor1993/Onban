//
//  DetailViewController.swift
//  onban
//
//  Created by Zeto on 2022/11/03.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    
    private var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private var verticalStackView = UIStackView().then {
        $0.distribution = .fill
        $0.axis = .vertical
    }
    
    private var mainImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        $0.collectionViewLayout = layout
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.register(DetailMainImageCell.self, forCellWithReuseIdentifier: DetailMainImageCell.reuseIdentifier)
    }
    
    private var detailTextView = DetailTextView()
    
    private let detailHash: String
    private let foodEntityData: OnbanFoodEntity
    
    init(detailHash: String, foodEntity: OnbanFoodEntity) {
        self.detailHash = detailHash
        self.foodEntityData = foodEntity
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.configureLayouts()
        self.configureDefaultData()
    }
}

private extension DetailViewController {
    
    func configureLayouts() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(verticalStackView)
        self.verticalStackView.addArrangedSubviews(mainImageCollectionView, detailTextView)
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        mainImageCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(verticalStackView.snp.width)
        }
        
        detailTextView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(625)
        }
    }
    
    func configureDefaultData() {
        detailTextView.setMainData(with: foodEntityData)
        
        // 임시 데이터
        detailTextView.setDescriptionData(with: "126원", deliveryInfo: "테스트 장소", deliveryFee: "2,500원")
    }
}
