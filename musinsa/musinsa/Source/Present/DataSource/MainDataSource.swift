//
//  MainDataSource.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import UIKit

final class MainViewDataSource: NSObject, UICollectionViewDataSource {

    private var subDataSources: [SubDataSource] = [BannerDataSource(), GridSectionDataSource(), ScrollDataSource(), StyleDataSource()]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subDataSources[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        return subDataSources[indexPath.section].dequeCell(from: collectionView, at: indexPath)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return subDataSources.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            return subDataSources[indexPath.section].reusableView(from: collectionView, kind: kind, at: indexPath)
    }
}

// MARK: - Providing Function

extension MainViewDataSource {
    func sectionProvider(sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
            subDataSources[sectionIndex].section
    }

    func setViewModel(with viewModels: [SectionViewModel]) {
        viewModels.enumerated().forEach { index, viewModel in
            subDataSources[index].configure(with: viewModel)
        }
    }
}
