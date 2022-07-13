//
//  BannerEntity.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation

struct BannerEntity: Decodable {
    let linkURL: String
    let thumbnailURL: String
    let title, description, keyword: String
}
