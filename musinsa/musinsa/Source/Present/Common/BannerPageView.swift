//
//  BannerPageView.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import UIKit

final class BannerPageView: UICollectionReusableView {
    static var identifier: String {
        return "\(self)"
    }

    private let label: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "1 / 20"
        label.backgroundColor = .gray
        label.font = .SFProDisplay.regular(12)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layoutLabel()
    }
}

// MARK: - Layout Section

private extension BannerPageView {
    func layoutLabel() {
        addSubview(label)

        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Providing Function

extension BannerPageView {
    func configure(with itemIndex: Int, at totalItems: Int) {
        label.text = "\(itemIndex+1)  /  \(totalItems)"
    }
}
