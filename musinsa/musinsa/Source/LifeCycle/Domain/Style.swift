//
//  Style.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import Foundation

struct Style: CellModelable {
    let identifier: String = StyleCell.identifier
    let linkURL: String
    let thumbnailURL: String
}
