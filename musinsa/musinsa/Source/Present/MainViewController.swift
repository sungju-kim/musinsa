//
//  MainViewController.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import UIKit

final class MainViewController: UIViewController {

    private let dataSource = MainViewDataSource()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: dataSource.sectionProvider)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GoodsCell.self, forCellWithReuseIdentifier: GoodsCell.identifier)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.register(StyleCell.self, forCellWithReuseIdentifier: StyleCell.identifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterView.identifier)
        collectionView.register(BannerPageView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionPaging, withReuseIdentifier: BannerPageView.identifier)
        collectionView.dataSource = dataSource
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutCollectionView()
    }
}

// MARK: - Layout Section

private extension MainViewController {
    func layoutCollectionView() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Providing Function

extension MainViewController {
    func bind(with viewModel: MainViewModel) {
        viewModel.didLoadData.bind {[weak self] domain in
            self?.dataSource.setDomain(with: domain)
            self?.collectionView.reloadData()
        }

        viewModel.loadData.accept(())
    }
}
