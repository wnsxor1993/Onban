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
        $0.alignment = .center
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
    
    private var mainImagePageControlView = UIPageControl().then {
        $0.hidesForSinglePage = true
        $0.numberOfPages = 0
        $0.currentPageIndicatorTintColor = .orange
        $0.pageIndicatorTintColor = .white
        $0.backgroundColor = .clear
    }
    
    private lazy var detailTextView = DetailTextView(with: foodEntityData)
    
    private let detailVM: DetailViewModel
    private let foodEntityData: OnbanFoodEntity
    private let disposeBag = DisposeBag()
    
    private lazy var input = DetailViewModel.Input(defaultShowingDataEvent: self.rx.viewWillAppear)
    private lazy var output = self.detailVM.transform(input: input, disposeBag: disposeBag)
    
    init(detailVM: DetailViewModel, foodEntity: OnbanFoodEntity) {
        self.detailVM = detailVM
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
        self.configureDataBinding()
        self.configureInnerBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.topItem?.title = foodEntityData.title
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        
        return CGSize(width: width, height: width)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let items = mainImageCollectionView.indexPathsForVisibleItems
        var index = mainImagePageControlView.currentPage
        
        if targetContentOffset.pointee.x > 0 {
            index += 1
        } else {
            index -= 1
        }
        
        guard index >= 0, index < mainImagePageControlView.numberOfPages, let _ = items[safe: index] else { return }
        
        mainImagePageControlView.currentPage = index
    }
}

private extension DetailViewController {
    
    func configureLayouts() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(verticalStackView)
        self.verticalStackView.addArrangedSubviews(mainImageCollectionView, detailTextView)
        self.verticalStackView.addSubview(mainImagePageControlView)
        
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
        
        mainImagePageControlView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(mainImageCollectionView.snp.bottom).offset(-18)
            make.height.equalTo(8)
        }
    }
    
    func configureDataBinding() {
        output.onbanDetailData
            .subscribe { [weak self] entity in
                guard let self = self, let entity = entity.element else { return }
                
                self.detailTextView.setDescriptionData(with: entity.point, deliveryInfo: entity.deliveryInfo, deliveryFee: entity.deliveryFee)
                self.mainImagePageControlView.numberOfPages = entity.thumbImageURLStrings.count
            }
            .disposed(by: disposeBag)
        
        output.onbanDetailThumbnailImages
            .map { return $0.compactMap { $0 } }
            .bind(to: mainImageCollectionView.rx.items(cellIdentifier: DetailMainImageCell.reuseIdentifier, cellType: DetailMainImageCell.self)) { _, value, cell in
                
                cell.setMainImage(with: value)
            }
            .disposed(by: disposeBag)
        
        self.mainImageCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        output.onbanDetailDescripImages
            .observe(on: MainScheduler.instance)
            .map { return $0.compactMap { $0 } }
            .subscribe { [weak self] datas in
                guard let self = self, let datas = datas.element else { return }
                
                var heightRatio: CGFloat = 0
                
                datas.forEach { data in
                    let image = UIImage(data: data)
                    heightRatio = (image?.size.height ?? 0) / (image?.size.width ?? 0)
                    
                    let imageView = UIImageView().then {
                        $0.contentMode = .scaleAspectFit
                        $0.image = image
                    }
                    
                    self.verticalStackView.addArrangedSubview(imageView)
                    
                    imageView.snp.makeConstraints { make in
                        make.leading.equalToSuperview().offset(16)
                        make.trailing.equalToSuperview().offset(-16)
                        make.height.equalTo(self.view.snp.width).multipliedBy(heightRatio).offset(-32)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    func configureInnerBinding() {
        detailTextView.setQuantityStepDriver()
            .drive { [weak self] value in
                self?.detailTextView.setQuantityAndAmount(with: value)
            }
            .disposed(by: disposeBag)
    }
}
