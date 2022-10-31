//
//  ViewController.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    
    private let sectionLabel = UILabel().then {
        $0.textColor = .sectionHeader
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 32, weight: .regular)
        $0.text = "모두가 좋아하는\n든든한 메인 요리"
    }
    
    private lazy var onbanCollectionView = UICollectionView().then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        
        $0.collectionViewLayout = layout
        $0.register(TotalFoodCell.self, forCellWithReuseIdentifier: TotalFoodCell.reuseIdentifier)
    }
    
    weak var deleage: Coordinator?
    
    private var viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayouts()
        self.configureFoodData()
    }
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        
        return CGSize(width: width, height: 130)
    }
}

private extension MainViewController {
    
    func configureLayouts() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.left.right.equalTo(self.view).offset(16)
            make.height.equalTo(96)
        }
        
        onbanCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel).offset(24)
            make.bottom.equalTo(self.view)
            make.left.right.equalTo(self.view).offset(16)
        }
    }
    
    // MARK: CollectionView Data Binidng with Rx
    func configureFoodData() {
        // TODO: ViewModel Observable 정의 및 Model 생성 필요
        let output = self.viewModel.transform(input: MainViewModel.CollectionViewInput(defaultShowingDataEvent: Observable.empty()), disposeBag: self.disposeBag)
        
        // Datasource binding
        output.onbanFoodData
            .bind(to: onbanCollectionView.rx
                .items(cellIdentifier: TotalFoodCell.reuseIdentifier, cellType: TotalFoodCell.self)) { [weak self] index, value, cell in
                    
                }
                .disposed(by: disposeBag)
        
        // cell select action
        onbanCollectionView.rx.modelSelected(OnbanFood.self)
            .bind { [weak self] model in
                
            }
            .disposed(by: disposeBag)
        
        // CollectionView delegate setting
        onbanCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}
