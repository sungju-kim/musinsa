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
        let type = SectionType.init(rawValue: type) ?? SectionType.grid
        let contents: [CellModelable]
        switch type {
        case .banner:
            contents = self.banners?.map { $0.toDomain() } ?? []
        case .scroll, .grid:
            contents = self.merchandise?.map { $0.toDomain() } ?? []
        case .style:
            contents = self.styles?.map { $0.toDomain() } ?? []
        }
        return Contents(data: contents)
    }
}
