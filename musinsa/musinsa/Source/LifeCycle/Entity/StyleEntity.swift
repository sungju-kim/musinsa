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
        let linkURL = URL(string: linkURL),
        thumbnailURL = URL(string: thumbnailURL)
        return Style(linkURL: linkURL,
                     thumbnailURL: thumbnailURL)
    }
}
