//
//  MainLayoutSection.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import Foundation

enum MainLayoutSection: Int, CaseIterable {
    case goods, goodsScroll, banner, style

    var indexSet: IndexSet {
        return IndexSet(integer: rawValue)
    }
}
