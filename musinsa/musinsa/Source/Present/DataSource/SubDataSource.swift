//
//  SubDataSource.swift
//  musinsa
//
//  Created by dale on 2022/07/17.
//

import UIKit

protocol SubDataSource {
    var section: NSCollectionLayoutSection { get }
    var count: Int { get }

    func configure(with viewModel: SectionViewModel)
    func dequeCell(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
    func reusableView(from collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> UICollectionReusableView
}
