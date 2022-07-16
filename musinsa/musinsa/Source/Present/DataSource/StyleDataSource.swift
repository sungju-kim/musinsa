//
//  StyleDataSource.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import UIKit

final class StyleDataSource {
    private var domain: Section?

    private var visibleDomainCounts: Int = 0

    var count: Int {
        let count = domain?.count ?? 0
        return visibleDomainCounts > count ? count : visibleDomainCounts
    }
}

// MARK: - Providing Function

extension StyleDataSource {
    func setDomain(section: Section) {
        domain = section
        guard let count = domain?.count else { return }
        visibleDomainCounts = count > 4 ? 4 : count
    }
}

// MARK: - Providing View

extension StyleDataSource: SubDataSource {
    var section: NSCollectionLayoutSection {
        let inset: CGFloat = 8
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: inset,
                                   leading: inset,
                                   bottom: inset,
                                   trailing: inset)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2)

        let groupContainer = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: group,
            count: 2)

        let section = NSCollectionLayoutSection(group: groupContainer)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                          heightDimension: .estimated(70)),
                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                        alignment: .top),
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .estimated(50),
                                                                          heightDimension: .estimated(50)),
                                                        elementKind: UICollectionView.elementKindSectionFooter,
                                                        alignment: .bottom)]

        return section
    }

    func dequeCell(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleCell.identifier, for: indexPath) as? StyleCell else {
            return UICollectionViewCell()
        }
        guard let cellViewModel = domain?.contents.data[indexPath.item] else { return cell}
        cell.configure(with: cellViewModel)
        return cell
    }

    func reusableView(from collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: HeaderView.identifier,
                                                                                   for: indexPath) as? HeaderView else { return UICollectionReusableView() }
            if let header = domain?.header {
                headerView.configure(with: header)
            }
            return headerView
        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: FooterView.identifier,
                                                                                   for: indexPath) as? FooterView else { return UICollectionReusableView() }
            if let footer = domain?.footer {
                footerView.configure(with: footer)
            }
            return footerView
        default:
            return UICollectionReusableView()
        }
    }
}
