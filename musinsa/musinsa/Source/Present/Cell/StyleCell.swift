//
//  StyleCell.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import UIKit
import SnapKit

final class StyleCell: UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layoutImageView()
    }
}

// MARK: - Layout Section

private extension StyleCell {
    func layoutImageView() {
        addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Providing Function

extension StyleCell: Cellable {
    func configure(with domain: CellModelable) {
        guard let domain = domain as? Style else { return }
    }

}
