//
//  Banner.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import Foundation

struct Banner: CellModelable {
    let identifier: String = BannerCell.identifier
    let linkURL: String
    let thumbnailURL: URL?
    let title, description, keyword: String
}
