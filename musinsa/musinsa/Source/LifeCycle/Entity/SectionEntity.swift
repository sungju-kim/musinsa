//
//  SectionEntity.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation

struct SectionEntity: Decodable {
    let contents: ContentsEntity
    let header: HeaderEntity
    let footer: FooterEntity
}

extension SectionEntity: DomainConvertable {
    func toDomain() -> Section {
        return Section(contents: contents.toDomain(),
                       header: header.toDomain(),
                       footer: footer.toDomain())
    }
}
