//
//  FooterView.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import UIKit

final class FooterView: UICollectionReusableView {
    static var identifier: String {
        return "\(self)"
    }
    @frozen enum LabelType: String {
        case recommand = "REFRESH"
        case more = "MORE"
    }
    private let button: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.titlePadding = 8
        configuration.imagePadding = 4
        configuration.imageColorTransformer = .grayscale
        let button = UIButton(configuration: configuration)
        button.layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.backgroundColor = .Musinsa.mainBackGroundColor
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitle("", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layoutButton()
    }

    override func prepareForReuse() {
        button.setTitle("", for: .normal)
        button.setImage(UIImage(), for: .normal)
    }
}

// MARK: - Layout Section

private extension FooterView {
    func layoutButton() {
        addSubview(button)

        button.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Providing Funtion

extension FooterView {
    func configure(with viewModel: FooterViewModel) {
        guard let type: LabelType = LabelType(rawValue: viewModel.footer.type) else { return }
        switch type {
        case .recommand:
            let image = UIImage(systemName: "goforward")
            button.setImage(image, for: .normal)
            button.setTitle("새로운 추천", for: .normal)
        case .more:
            button.setTitle("더보기", for: .normal)
        }

        button.addAction(UIAction { _ in
            viewModel.action.accept(())
        }, for: .touchUpInside)
    }
}
