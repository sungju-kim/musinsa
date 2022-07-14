//
//  FooterEntity.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation

struct FooterEntity: Decodable {
    let type, title: String
    let iconURL: String?
}

extension FooterEntity: DomainConvertable {
    func toDomain() -> Footer {
        let url = URL(string: iconURL ?? "")
        return Footer(type: type,
                      title: title,
                      iconURL: url)
    }
}
