//
//  StyleEntity.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation

struct StyleEntity: Decodable {
    let linkURL: String
    let thumbnailURL: String
}

extension StyleEntity: DomainConvertable {
    func toDomain() -> Style {
        return Style(linkURL: linkURL,
                     thumbnailURL: thumbnailURL)
    }
}
