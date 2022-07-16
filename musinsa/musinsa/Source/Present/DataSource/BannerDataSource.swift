//
//  BannerDataSource.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import UIKit

final class BannerDataSource {
    private var viewModel: BannerViewModel?

    var count: Int {
        viewModel?.count ?? 0
    }
}

// MARK: - Providing Function

extension BannerDataSource {
    func setDomain(section: Section) {
        viewModel = BannerViewModel(section: section)
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

        section.visibleItemsInvalidationHandler = {[weak self] cells, offset, _ in
            guard let page = Int(exactly: offset.x / (cells[0].frame.width + (inset*2))) else { return }
            self?.viewModel?.pageDidChange.accept(page)
        }

        return section
    }

    func dequeCell(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
            return UICollectionViewCell()
        }
        guard let cellViewModel = viewModel?[indexPath.item] else { return cell}
        cell.configure(with: cellViewModel)
        return cell
    }

    func reusableView(from collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionPaging:
            guard let pageView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                 withReuseIdentifier: BannerPageView.identifier,
                                                                                 for: indexPath) as? BannerPageView else { return UICollectionReusableView() }
            guard let pageViewModel = viewModel?.pageViewModel else { return pageView }
            pageView.configure(with: pageViewModel)
            return pageView
        default:
            return UICollectionReusableView()
        }
    }
}
