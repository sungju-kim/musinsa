//
//  MusinsaEndPoint.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import Foundation
import Alamofire

enum MusinsaEndPoint {
    case main
}

extension MusinsaEndPoint: Requestable {
    var baseURL: URL? {
        switch self {
        case .main:
            return URL(string: "https://meta.musinsa.com/interview/list.json")
        }
    }

    var path: String? {
        switch self {
        case .main:
            return nil
        }
    }

    var url: URL? {
        guard let path = path else { return baseURL }
        return baseURL?.appendingPathComponent(path)
    }

    var headers: HTTPHeaders {
        switch self {
        case .main:
            return []
        }
    }
    var parameter: [String: Any] {
        switch self {
        case .main:
            return [:]
        }
    }
    var method: HTTPMethod {
        switch self {
        case .main:
            return .get
        }
    }
}
