//
//  MainViewController.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import UIKit

final class MainViewController: UIViewController {
    private var domain: Products?

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: LayoutFactory.create())
        collectionView.register(GoodsCell.self, forCellWithReuseIdentifier: GoodsCell.identifier)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.register(StyleCell.self, forCellWithReuseIdentifier: StyleCell.identifier)
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
    func setDomain(with domain: Products) {
        self.domain = domain
    }
}
