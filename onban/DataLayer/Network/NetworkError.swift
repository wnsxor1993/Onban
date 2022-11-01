//
//  NetworkError.swift
//  onban
//
//  Created by Zeto on 2022/10/31.
//

import Foundation

enum NetworkError: Error {
    case serviceCaseError
    case statusCodeError
    case moyaNetworkError
    case decodingError
    case encodingError
}
