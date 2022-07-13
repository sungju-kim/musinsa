//
//  NetworkError.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case failToDecode
    case emptyData
}
