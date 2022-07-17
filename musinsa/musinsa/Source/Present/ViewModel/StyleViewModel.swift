//
//  StyleViewModel.swift
//  musinsa
//
//  Created by dale on 2022/07/17.
//

import Foundation

final class StyleViewModel: SectionViewModel {
    private var section: Section
    private(set) var headerViewModel: HeaderViewModel?
    private(set) var footerViewModel: FooterViewModel?

    private var visibleCount: Int = 4
    var count: Int {
        return visibleCount
    }

    let updateIndex = PublishRelay<[Int]>()

    subscript(_ index: Int) -> CellModelable? {
        return section.contents[index]
    }

    init(section: Section) {
        self.section = section
        headerViewModel = HeaderViewModel(header: section.header)
        footerViewModel = FooterViewModel(footer: section.footer)
        bind()
    }
}

// MARK: - Bind

extension StyleViewModel {
    func bind() {
        footerViewModel?.tappedMoreContext.bind {[weak self] _ in
            guard let total = self?.section.count,
                  let current = self?.visibleCount else { return }
            let remain = total - current
            let update = min(remain, 4)
            self?.visibleCount += update
            let array = Array(current..<current+update)
            self?.updateIndex.accept(array)
        }
    }
}
