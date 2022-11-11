//
//  FileCachedManager.swift
//  onban
//
//  Created by Zeto on 2022/11/02.
//

import UIKit

class FileCachedManager {

    static let shared = NSCache<NSString, NSData>()
    static let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first

    static func saveData(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            guard let data = NSData(contentsOf: url) else { return }
            
            // Path가 너무 길면 저장에 문제가 생길 수 있으므로 .lastPathComponent를 통해 짧게 유지
            shared.setObject(data, forKey: NSString(string: url.lastPathComponent))

            guard let pathURL = path else { return }
            let fileManager = FileManager()
            var filePath = URL(fileURLWithPath: pathURL)
            filePath.appendPathComponent(url.lastPathComponent)

            guard !fileManager.fileExists(atPath: filePath.path) else { return }

            fileManager.createFile(atPath: filePath.path, contents: data as Data)
        }
    }

    static func loadData(validURL: URL) -> Data? {
        guard let data = shared.object(forKey: NSString(string: validURL.lastPathComponent)) else {

            guard let pathURL = path else { return nil }
            let fileManager = FileManager()
            var filePath = URL(fileURLWithPath: pathURL)
            filePath.appendPathComponent(validURL.lastPathComponent)

            if fileManager.fileExists(atPath: filePath.path) {
                guard let data = try? Data(contentsOf: filePath) else { return nil }

                return data
                
            } else {
                return nil
            }
        }
        
        return data as Data
    }
}
