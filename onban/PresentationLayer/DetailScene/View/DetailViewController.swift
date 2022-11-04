//
//  DetailViewController.swift
//  onban
//
//  Created by Zeto on 2022/11/03.
//

import UIKit
import Then
import SnapKit
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
    
    private var descriptionImageTableView = UITableView().then {
        $0.register(DetailDescriptionImageCell.self, forCellReuseIdentifier: DetailDescriptionImageCell.reuseIdentifier)
        $0.isScrollEnabled = false
        $0.showsVerticalScrollIndicator = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayouts()
    }
}

private extension DetailViewController {
    
    func configureLayouts() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(verticalStackView)
        self.verticalStackView.addArrangedSubviews(mainImageCollectionView, detailTextView, descriptionImageTableView)
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        mainImageCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(verticalStackView.snp.width)
        }
        
        detailTextView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(625)
        }
        
        descriptionImageTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(1000)
        }
    }
}
