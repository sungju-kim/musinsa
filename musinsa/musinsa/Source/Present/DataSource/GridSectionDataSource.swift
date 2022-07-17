//
//  GridSectionDataSource.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import UIKit

final class GridSectionDataSource {
    private var viewModel: GridViewModel?
    private var visibleDomainCounts: Int = 0

    var count: Int {
        return viewModel?.count ?? 0
    }

    init() {
        bind()
    }
}

// MARK: - Bind

private extension GridSectionDataSource {
    func bind() {

    }
}

// MARK: - Providing View

extension GridSectionDataSource: SubDataSource {
    func configure(with viewModel: SectionViewModel) {
        self.viewModel = viewModel as? GridViewModel
    }

    var section: NSCollectionLayoutSection {
        let inset: CGFloat = 8

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: inset,
                                   leading: inset,
                                   bottom: inset,
                                   trailing: inset)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let containerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(400))
        let groupContainer = NSCollectionLayoutGroup.vertical(layoutSize: containerSize, subitem: group, count: 2)

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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodsCell.identifier, for: indexPath) as? GoodsCell else {
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
            if let headerViewModel = viewModel?.headerViewModel {
                headerView.configure(with: headerViewModel)
            }
            return headerView
        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: FooterView.identifier,
                                                                                   for: indexPath) as? FooterView else { return UICollectionReusableView() }
            if let footerViewModel = viewModel?.footerViewModel {
                footerView.configure(with: footerViewModel)
            }
            return footerView
        default:
            return UICollectionReusableView()
        }
    }
}
