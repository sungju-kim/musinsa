//
//  ContentsEntity.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation

struct ContentsEntity: Decodable {
    let type: String
    let banners: [BannerEntity]?
    let merchandise: [GoodsEntity]?
    let styles: [StyleEntity]?

    enum CodingKeys: String, CodingKey {
        case type, banners, styles
        case merchandise = "goods"
    }
}

extension ContentsEntity: DomainConvertable {
    func toDomain() -> Contents {
        let banners = banners?.map { $0.toDomain() }
        let merchandise = merchandise?.map { $0.toDomain() }
        let styles = styles?.map { $0.toDomain() }
        return Contents(type: type,
                        banners: banners,
                        merchandise: merchandise,
                        styles: styles)
    }
}
