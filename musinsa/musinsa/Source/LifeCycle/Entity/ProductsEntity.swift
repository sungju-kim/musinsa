//
//  ProductsEntity.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation

struct ProductsEntity: Decodable {
    let sections: [SectionEntity]

    enum CodingKeys: String, CodingKey {
        case sections = "data"
    }
}

extension ProductsEntity: DomainConvertable {
    func toDomain() -> Products {
        let sections = sections.map { $0.toDomain() }
        return Products(sections: sections)
    }
}
