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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodsCell.identifier, for: indexPath) as? GoodsCell else {
            return UICollectionViewCell()
        }

        return cell
    }
}

// MARK: - Providing Function

extension MainViewDataSource {
    func setDomain(with domain: [Section]) {
        self.domain = domain
    }
}
