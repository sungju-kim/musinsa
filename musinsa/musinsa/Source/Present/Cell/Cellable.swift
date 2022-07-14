//
//  Cellable.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import UIKit

protocol Cellable: UICollectionViewCell {
    func configure(with domain: CellModelable)
}
