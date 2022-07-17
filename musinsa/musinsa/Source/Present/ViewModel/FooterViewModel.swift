//
//  FooterViewModel.swift
//  musinsa
//
//  Created by dale on 2022/07/17.
//

import Foundation

final class FooterViewModel {
    private(set) var footer: Footer

    let action = PublishRelay<Void>()

    let tappedRefresh = PublishRelay<Void>()
    let tappedMoreContext = PublishRelay<Void>()
    init?(footer: Footer?) {
        guard let footer = footer else { return nil }
        self.footer = footer

        bind()
    }
}

// MARK: - Bind

extension FooterViewModel {
    func bind() {
        action.bind {[weak self] _ in
            guard let rawValue = self?.footer.type,
                  let type = FooterView.LabelType(rawValue: rawValue) else { return }
            switch type {
            case .more:
                self?.tappedMoreContext.accept(())
            case .recommand:
                self?.tappedRefresh.accept(())
            }
        }
    }
}
