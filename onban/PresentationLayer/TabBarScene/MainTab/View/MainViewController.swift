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
    
    private lazy var onbanCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        
        $0.collectionViewLayout = layout
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(TotalFoodCell.self, forCellWithReuseIdentifier: TotalFoodCell.reuseIdentifier)
    }
    
    weak var deleage: Coordinator?
    
    private var viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    private lazy var input = MainViewModel.CollectionViewInput(defaultShowingDataEvent: self.rx.viewWillAppear)
    private lazy var output = self.viewModel.transform(input: input, disposeBag: self.disposeBag)
    
    
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
        let width = (self.view.frame.width - 32)
        
        return CGSize(width: width, height: 130)
    }
}

private extension MainViewController {
    
    func configureLayouts() {
        self.view.addSubviews(sectionLabel, onbanCollectionView)
        
        sectionLabel.snp.makeConstraints { [weak self] make in
            guard let self = self else { return }
            
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(96)
        }
        
        onbanCollectionView.snp.makeConstraints { make in
            
            make.top.equalTo(sectionLabel.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: CollectionView Data Binidng with Rx
    func configureFoodData() {
        // TODO: ViewModel Observable 정의 및 Model 생성 필요
        // Datasource binding
        self.output.onbanFoodData
            .bind(to: onbanCollectionView.rx
                .items(cellIdentifier: TotalFoodCell.reuseIdentifier, cellType: TotalFoodCell.self)) { index, value, cell in
                    let image = UIImage(data: value.image)
                    
                    cell.setFoodValues(image: image, title: value.title, description: value.bodyDescription, amount: value.nPrice, discount: value.sPrice)
                    
                    guard let badges = value.badge, cell.checkNowEventBadgeCounts() != badges.count else { return }
                    
                    badges.forEach {
                        cell.setEventLabel($0)
                    }
                }
                .disposed(by: disposeBag)
        
        // cell select action
        self.onbanCollectionView.rx.modelSelected(OnbanFoodEntity.self)
            .bind { [weak self] model in
                guard let self = self else { return }
                
                // TODO: 셀 선택 시 상세 화면 이동 로직 구현 예정
            }
            .disposed(by: disposeBag)
        
        // CollectionView delegate setting
        self.onbanCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}
