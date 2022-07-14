//
//  HeaderEntity.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation

struct HeaderEntity: Decodable {
    let title: String
    let iconURL, linkURL: String?
}

extension HeaderEntity: DomainConvertable {
    func toDomain() -> Header {
        let iconURL = URL(string: iconURL ?? "")
        let linkURL = URL(string: linkURL ?? "")

        return Header(title: title,
                      iconURL: iconURL,
                      linkURL: linkURL)
    }
}
