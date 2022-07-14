//
//  Goods.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import Foundation

struct Goods: CellModelable {
    let linkUrl: String
    let thumbnailURL: String
    let brandName: String
    let price: Int
    let saleRate: Int
    let hasCoupon: Bool
}
