//
//  GoodsCell.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import UIKit
import SnapKit

final class GoodsCell: UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = .makeCustomLabel(" ", .SFProDisplay.regular(12), .gray)
    private lazy var priceLabel: UILabel = .makeCustomLabel(" ", .SFProDisplay.bold(12), .black)
    private lazy var discountLabel: UILabel = .makeCustomLabel(" ", .SFProDisplay.bold(8), .red)

    private lazy var couponLabel: UILabel = {
        let label: UILabel = .makeCustomLabel("쿠폰", .SFProDisplay.semiBold(8), .Musinsa.mainBackGroundColor)
        label.backgroundColor = UIColor.tintColor
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 3
        return label
    }()

    private lazy var labelContainer: UIStackView = {
        let stackView = UIStackView()
        [priceLabel, discountLabel, couponLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutLabelContainer()
        layoutTitleLabel()
        layoutImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutLabelContainer()
        layoutTitleLabel()
        layoutImageView()
    }
}

// MARK: - Layout Section

private extension GoodsCell {
    func layoutImageView() {
        addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top)
        }
    }

    func layoutTitleLabel() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(labelContainer.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(titleLabel.intrinsicContentSize.height)
        }
    }

    func layoutLabelContainer() {
        addSubview(labelContainer)

        labelContainer.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(priceLabel.intrinsicContentSize.height)
        }
    }
}

// MARK: - Configure

extension GoodsCell: Cellable {
    func configure(with domain: CellModelable) {
        guard let domain = domain as? Goods else { return }
        titleLabel.text = domain.brandName
        couponLabel.isHidden = !domain.hasCoupon
        priceLabel.text = domain.price.decimalWon()
        discountLabel.text = "\(domain.saleRate)%"

        if let text = discountLabel.text {
            let attributed = NSMutableAttributedString(string: text)
            attributed.addAttribute(.font, value: UIFont.SFProDisplay.semiBold(6) as Any, range: (text as NSString).range(of: "%"))
            discountLabel.attributedText = attributed
        }

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
