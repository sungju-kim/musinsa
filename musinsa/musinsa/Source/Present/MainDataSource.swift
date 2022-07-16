//
//  MainDataSource.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import UIKit

final class MainViewDataSource: NSObject, UICollectionViewDataSource {

    private var domain: [Section]?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return domain?[section].count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellDomain = domain?[indexPath.section].contents[indexPath.item] else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellDomain.identifier, for: indexPath) as? Cellable else {
            return UICollectionViewCell()
        }
        cell.configure(with: cellDomain)
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return domain?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: HeaderView.identifier,
                                                                                   for: indexPath) as? HeaderView else { return UICollectionReusableView() }
            if let header = domain?[indexPath.section].header {
                headerView.configure(with: header)
            }
            return headerView
        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: FooterView.identifier,
                                                                                   for: indexPath) as? FooterView else { return UICollectionReusableView() }
            if let footer = domain?[indexPath.section].footer {
                footerView.configure(with: footer)
            }
            return footerView
        case UICollectionView.elementKindSectionPaging:
            guard let pageView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: BannerPageView.identifier,
                                                                                   for: indexPath) as? BannerPageView else { return UICollectionReusableView() }
            pageView.configure(with: indexPath.item, at: domain?[indexPath.section].count ?? 0)
            return pageView
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - Providing Function

extension MainViewDataSource {
    func setDomain(with domain: [Section]) {
        self.domain = domain
    }
}
