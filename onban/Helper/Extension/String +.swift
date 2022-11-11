//
//  String +.swift
//  onban
//
//  Created by Zeto on 2022/10/28.
//

import UIKit

extension String {
    
    // 가운데 줄 긋기 효과
    func strikeThrough() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
}
