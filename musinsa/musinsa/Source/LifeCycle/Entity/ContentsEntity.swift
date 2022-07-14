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
    func toDomain() -> [CellModelable] {
        guard let type = SectionType.init(rawValue: type) else { return [] }
        switch type {
        case .banner:
            return self.banners?.map { $0.toDomain() } ?? []
        case .scroll, .grid:
            return self.merchandise?.map { $0.toDomain() } ?? []
        case .style:
            return self.styles?.map { $0.toDomain() } ?? []
        }
    }
}
