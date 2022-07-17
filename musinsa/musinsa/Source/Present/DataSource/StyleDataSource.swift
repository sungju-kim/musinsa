//
//  StyleDataSource.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import UIKit

final class StyleDataSource {
    private var viewModel: StyleViewModel?

    var count: Int {
        return viewModel?.count ?? 0
    }
}

// MARK: - Providing View

extension StyleDataSource: SubDataSource {
    func configure(with viewModel: SectionViewModel) {
        self.viewModel = viewModel as? StyleViewModel
    }

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
        guard let cellViewModel = viewModel?[indexPath.item] else { return cell}
        cell.configure(with: cellViewModel)
        return cell
    }

    func reusableView(from collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: HeaderView.identifier,
                                                                                   for: indexPath) as? HeaderView else { return UICollectionReusableView() }
            if let header = viewModel?.headerViewModel {
                headerView.configure(with: header)
            }
            return headerView
        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: FooterView.identifier,
                                                                                   for: indexPath) as? FooterView else { return UICollectionReusableView() }
            if let footer = viewModel?.footerViewModel {
                footerView.configure(with: footer)
            }
            return footerView
        default:
            return UICollectionReusableView()
        }
    }
}
