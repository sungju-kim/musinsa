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
