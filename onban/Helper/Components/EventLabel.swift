//
//  EventLabel.swift
//  onban
//
//  Created by Zeto on 2022/11/04.
//

import UIKit
import SnapKit

// TODO: DetailVC UI 완성 후, 갈아끼우기
final class EventLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureSettings()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelEvent(with eventText: String) {
        switch eventText {
        case "런칭특가", "메인특가":
            self.backgroundColor = .launchingEvent
            self.text = eventText
            self.configureLayout(with: 77)
            
        case "이벤트특가":
            self.backgroundColor = .eventAmount
            self.text = eventText
            self.configureLayout(with: 89)
            
        default:
            return
        }
    }
}

private extension EventLabel {
    
    func configureSettings() {
        self.font = .systemFont(ofSize: 12, weight: .semibold)
        self.textColor = .white
        self.textAlignment = .center
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
    }
    
    func configureLayout(with width: CGFloat) {
        self.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalToSuperview()
        }
    }
}
