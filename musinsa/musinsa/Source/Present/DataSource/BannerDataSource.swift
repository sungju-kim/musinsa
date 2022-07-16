//
//  BannerDataSource.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import UIKit

final class BannerDataSource {
    private var domain: Section?

    var count: Int {
        domain?.count ?? 0
    }
}

// MARK: - Providing Function

extension BannerDataSource {
    func setDomain(section: Section) {
        domain = section
    }
}

// MARK: - Providing View

extension BannerDataSource: SubDataSource {
    var section: NSCollectionLayoutSection {
        let inset: CGFloat = 8
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: inset,
                                   leading: inset,
                                   bottom: inset,
                                   trailing: inset)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                       subitem: item,
                                                       count: 1)

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .groupPaging

        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .estimated(70),
                                                                          heightDimension: .estimated(1)),
                                                        elementKind: UICollectionView.elementKindSectionPaging,
                                                        alignment: .bottomTrailing)]
        section.contentInsets = .init(top: 0,
                                      leading: 0,
                                      bottom: -inset*7,
                                      trailing: inset*3)

        return section
    }

    func dequeCell(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
            return UICollectionViewCell()
        }
        guard let cellViewModel = domain?.contents.data[indexPath.item] else { return cell}
        cell.configure(with: cellViewModel)
        return cell
    }

    func reusableView(from collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionPaging:
            guard let pageView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                 withReuseIdentifier: BannerPageView.identifier,
                                                                                 for: indexPath) as? BannerPageView else { return UICollectionReusableView() }
            return pageView
        default:
            return UICollectionReusableView()
        }
    }
}
