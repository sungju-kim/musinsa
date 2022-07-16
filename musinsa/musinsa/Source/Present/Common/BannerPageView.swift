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
        label.padding = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)

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
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Providing Function

extension BannerPageView {
    func configure(with viewModel: PageViewModel) {
        viewModel.didChangePage.bind {[weak self] current, total in
            self?.label.text = "\(current) / \(total)"
        }
    }
}
