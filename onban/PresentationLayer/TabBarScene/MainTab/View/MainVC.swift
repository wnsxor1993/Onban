//
//  ViewController.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit
import Then
import SnapKit
import RxCocoa

final class MainViewController: UIViewController {
    
    private var sectionLabel = UILabel().then {
        $0.textColor = .sectionHeader
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 32, weight: .regular)
        $0.text = "모두가 좋아하는\n든든한 메인 요리"
    }
    
    private lazy var collectionView = UICollectionView().then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        $0.collectionViewLayout = layout
        $0.delegate = self
    }
    
    weak var deleage: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayouts()
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

private extension MainViewController {
    
    func configureLayouts() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.left.right.equalTo(self.view).offset(16)
            make.height.equalTo(96)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel).offset(24)
            make.bottom.equalTo(self.view)
            make.left.right.equalTo(self.view).offset(16)
        }
    }
}
