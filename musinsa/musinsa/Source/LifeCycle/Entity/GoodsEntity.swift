//
//  GoodsEntity.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation

struct GoodsEntity: Decodable {
    let linkURL: String
    let thumbnailURL: String
    let brandName: String
    let price: Int
    let saleRate: Int
    let hasCoupon: Bool
}

extension GoodsEntity: DomainConvertable {
    func toDomain() -> Goods {
        let thumbnailURL = URL(string: thumbnailURL)
        return Goods(linkUrl: linkURL,
                     thumbnailURL: thumbnailURL,
                     brandName: brandName,
                     price: price,
                     saleRate: saleRate,
                     hasCoupon: hasCoupon)
    }
}
