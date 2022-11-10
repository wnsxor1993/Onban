//
//  Array +.swift
//  onban
//
//  Created by Zeto on 2022/11/09.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        
        return indices.contains(index) ? self[index] : nil
    }
}
