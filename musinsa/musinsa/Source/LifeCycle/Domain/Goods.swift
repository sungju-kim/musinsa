//
//  Goods.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import Foundation

struct Goods: CellModelable {
    let identifier: String = GoodsCell.identifier
    let linkUrl: String
    let thumbnailURL: URL?
    let brandName: String
    let price: Int
    let saleRate: Int
    let hasCoupon: Bool
}
