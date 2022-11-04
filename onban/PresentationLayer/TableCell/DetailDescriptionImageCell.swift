//
//  DetailDescriptionImageCell.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit
import Then
import SnapKit

final class DetailDescriptionImageCell: UITableViewCell {
    
    private var detailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    static let reuseIdentifier = "DetailDescriptionImageCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.resetDataForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
}

private extension DetailDescriptionImageCell {
    
    func configureLayouts() {
        self.addSubview(detailImageView)
        
        self.detailImageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func resetDataForReuse() {
        self.detailImageView.image = nil
    }
}
