//
//  DetailMainImageCell.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit
import Then
import SnapKit

final class DetailMainImageCell: UICollectionViewCell {
    
    private var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    static let reuseIdentifier = "DetailMainImageCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.resetDataForReuse()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    func setMainImage(with data: Data) {
        self.imageView.image = UIImage(data: data)
    }
}

private extension DetailMainImageCell {
    
    func configureLayouts() {
        self.addSubview(imageView)
        
        self.imageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func resetDataForReuse() {
        self.imageView.image = nil
    }
}
