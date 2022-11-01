//
//  JSONConverter.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation

struct JSONConverter<T: Codable> {
    
    typealias Model = T
    
    func decode(data: Data) -> Model? {
        guard let json = try? JSONDecoder().decode(Model.self, from: data) else { return nil }
        
        return json
    }

    func encode(model: Model) -> Data? {
        guard let data = try? JSONEncoder().encode(model) else { return nil }
        
        return data
    }
}
