//
//  BannerViewModel.swift
//  musinsa
//
//  Created by dale on 2022/07/17.
//

import Foundation

final class BannerViewModel {
    private var section: Section
    let pageViewModel: PageViewModel = PageViewModel()

    var count: Int {
        return section.count
    }

    let pageDidChange = PublishRelay<Int>()

    subscript(_ index: Int) -> CellModelable? {
        return section.contents[index]
    }

    init(section: Section) {
        self.section = section
        bind()
    }
}

// MARK: - Bind

extension BannerViewModel {
    func bind() {
        pageDidChange.bind {[weak self] page in
            guard let count = self?.count else { return }
            self?.pageViewModel.didChangePage.accept((page+1, count))
        }
    }
}
