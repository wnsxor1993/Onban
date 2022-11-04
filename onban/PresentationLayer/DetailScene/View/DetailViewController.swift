//
//  DetailViewController.swift
//  onban
//
//  Created by Zeto on 2022/11/03.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
