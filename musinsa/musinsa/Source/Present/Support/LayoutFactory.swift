//
//  LayoutFactory.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import UIKit

enum LayoutFactory {
    static func create() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let sectionKind = MainLayoutSection(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            switch sectionKind {
            case .goods:
                section = createGoodsSection(scrollable: false)
            case .goodsScroll:
                section = createGoodsSection(scrollable: true)
            case .banner:
                section = createBannerSection()
            case .style:
                section = createStyleSection()
            }
            return section
        }
    }

    static func createGoodsSection(scrollable: Bool) -> NSCollectionLayoutSection {
        let inset: CGFloat = 8

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: inset, leading: inset, bottom: inset, trailing: inset)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        var section = NSCollectionLayoutSection(group: group)

        if !scrollable {
            let containerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(400))
            let groupContainer = NSCollectionLayoutGroup.vertical(layoutSize: containerSize, subitem: group, count: 2)
            section = NSCollectionLayoutSection(group: groupContainer)
        }
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    static func createBannerSection() -> NSCollectionLayoutSection {
        let inset: CGFloat = 8
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: inset, leading: inset, bottom: inset, trailing: inset)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    static func createStyleSection() -> NSCollectionLayoutSection {
        let inset: CGFloat = 8
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: inset, leading: inset, bottom: inset, trailing: inset)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )

        let groupContainer = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: group,
            count: 2
        )

        let section = NSCollectionLayoutSection(group: groupContainer)

        return section
    }
}
