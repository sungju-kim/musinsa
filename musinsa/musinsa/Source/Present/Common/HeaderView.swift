//
//  HeaderView.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import UIKit
import SnapKit

final class HeaderView: UICollectionReusableView {
    static var identifier: String {
        return "\(self)"
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label: UILabel = .makeCustomLabel("", .SFProDisplay.bold(16), .black)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private lazy var linkButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 >", for: .normal)
        button.titleLabel?.font = .SFProDisplay.regular(12)
        button.setTitleColor(.lightGray, for: .normal)
        button.isHidden = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutTitleLabel()
        layoutImageView()
        layoutLinkButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layoutTitleLabel()
        layoutImageView()
        layoutLinkButton()
    }

    override func prepareForReuse() {
        imageView.image = UIImage()
        titleLabel.text = ""
        linkButton.isHidden = true
    }
}

// MARK: - Layout Section

private extension HeaderView {
    func layoutImageView() {
        let inset: CGFloat = 4
        addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.trailing.equalTo(titleLabel.snp.leading).inset(-inset)
            make.top.equalTo(titleLabel.snp.top)
            make.height.equalTo(titleLabel.intrinsicContentSize.height)
            make.width.equalTo(titleLabel.intrinsicContentSize.height)
        }
    }

    func layoutTitleLabel() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func layoutLinkButton() {
        let inset: CGFloat = 8
        addSubview(linkButton)

        linkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-inset)
            make.centerY.equalToSuperview()
        }
    }

    func updateTitleLayout() {
        let inset: CGFloat = 4
        titleLabel.snp.updateConstraints { make in
            make.centerX.equalToSuperview().offset(imageView.frame.width + inset)
        }
    }
}

// MARK: - Providing Function

extension HeaderView {
    func configure(with domain: Header) {
        titleLabel.text = domain.title.replacingOccurrences(of: ":", with: "\n")

        ImageManager.shared.downLoadImage(from: domain.iconURL) { [weak self]result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                    self?.updateTitleLayout()
                    if let linkURL = domain.linkURL {
                        self?.linkButton.isHidden = false
                        _ = linkURL
                        // MARK: - TODO url 연결
                    }
                }
            case .failure(let error):
                _ = error
                // MARK: - TODO Error Handling
            }
        }
    }
}
