//
//  BannerCell.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import UIKit
import SnapKit

final class BannerCell: UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var keywordLabel: UILabel = .makeCustomLabel(" ", .SFProDisplay.semiBold(12), .Musinsa.mainBackGroundColor)
    private lazy var titleLabel: UILabel = {
        let label: UILabel = .makeCustomLabel(" ", .SFProDisplay.bold(20), .Musinsa.mainBackGroundColor)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    private lazy var descriptionLabel: UILabel = .makeCustomLabel(" ", .SFProDisplay.regular(12), .Musinsa.mainBackGroundColor)

    // MARK: - TODO 페이징 기능 구현 필요

    private lazy var pageLabel: UILabel = {
        let label: UILabel = .makeCustomLabel(" ", .SFProDisplay.regular(12), .Musinsa.mainBackGroundColor)
        label.backgroundColor = .systemGray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutImageView()
        layoutKeywordLabel()
        layoutDescriptionLabel()
        layoutPageLabel()
        layoutTitleLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layoutImageView()
        layoutKeywordLabel()
        layoutDescriptionLabel()
        layoutPageLabel()
        layoutTitleLabel()
    }

}

// MARK: - Layout Section

private extension BannerCell {
    func layoutImageView() {
        addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func layoutKeywordLabel() {
        let inset: CGFloat = 16

        addSubview(keywordLabel)

        keywordLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(inset)
        }
    }

    func layoutTitleLabel() {
        let inset: CGFloat = 16

        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(inset)
            make.width.equalTo(self.frame.width/2)
            make.bottom.equalTo(descriptionLabel.snp.top).inset(-inset)
        }
    }

    func layoutDescriptionLabel() {
        let inset: CGFloat = 16

        addSubview(descriptionLabel)

        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(inset)
        }
    }

    func layoutPageLabel() {
        let inset: CGFloat = 16

        addSubview(pageLabel)

        pageLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(inset)
        }
    }
}

// MARK: - Configure

extension BannerCell: Cellable {
    func configure(with domain: CellModelable) {
        guard let domain = domain as? Banner else { return }
        titleLabel.text = domain.title
        descriptionLabel.text = domain.description
        ImageManager.shared.downLoadImage(from: domain.thumbnailURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            case .failure(let error):
                _ = error
                // MARK: - TODO Error Handling
            }
        }
    }
}
