//
//  Section.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import Foundation

struct Section {
    let contents: [CellModelable]
    let header: Header?
    let footer: Footer?

    var count: Int {
        return contents.count
    }
}
