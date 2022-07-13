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
