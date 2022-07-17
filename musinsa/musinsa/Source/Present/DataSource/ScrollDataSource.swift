//
//  ScrollDataSource.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import UIKit

final class ScrollDataSource {
    private var viewModel: ScrollViewModel?

    var count: Int {
        return viewModel?.count ?? 0
    }
}

// MARK: - Providing View

extension ScrollDataSource: SubDataSource {
    func configure(with viewModel: SectionViewModel) {
        self.viewModel = viewModel as? ScrollViewModel
    }

    var section: NSCollectionLayoutSection {
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

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                          heightDimension: .estimated(70)),
                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                        alignment: .top),
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .estimated(50), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)]
        return section
    }

    func dequeCell(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodsCell.identifier, for: indexPath) as? GoodsCell else {
            return UICollectionViewCell()
        }
        guard let cellModel = viewModel?[indexPath.item] else { return cell}
        cell.configure(with: cellModel)
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
