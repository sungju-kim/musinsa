//
//  Contents.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import Foundation

struct Contents {
    let data: [CellModelable]

    var count: Int {
        data.count
    }

    subscript(index: Int) -> CellModelable? {
        return data[index]
    }
}
