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
}

// MARK: - Providing Function

extension MainViewDataSource {
    func setDomain(with domain: [Section]) {
        self.domain = domain
    }
}
