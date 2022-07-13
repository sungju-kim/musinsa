//
//  GoodsEntity.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation

struct GoodsEntity: Decodable {
    let linkUrl: String
    let thimbnailURL: String
    let brandName: String
    let price: Int
    let saleRate: Int
    let hasCoupon: Bool
}
