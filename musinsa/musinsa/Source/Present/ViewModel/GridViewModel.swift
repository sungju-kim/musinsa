//
//  GridViewModel.swift
//  musinsa
//
//  Created by dale on 2022/07/17.
//

import Foundation

final class GridViewModel: SectionViewModel {
    private var section: Section
    private(set) var headerViewModel: HeaderViewModel?
    private(set) var footerViewModel: FooterViewModel?

    private var visibleCount: Int = 6
    var count: Int {
        return visibleCount
    }

    let updateIndex = PublishRelay<[Int]>()

    subscript(_ index: Int) -> CellModelable? {
        return section.contents[index]
    }

    init(section: Section) {
        self.section = section
        self.footerViewModel = FooterViewModel(footer: section.footer)
        self.headerViewModel = HeaderViewModel(header: section.header)
        visibleCount = min(visibleCount, section.count)

        bind()
    }
}

// MARK: - Bind

extension GridViewModel {
    func bind() {
        footerViewModel?.tappedMoreContext.bind {[weak self] _ in
            guard let total = self?.section.count,
                  let current = self?.visibleCount else { return }
            let remain = total - current
            let update = min(remain, 3)
            self?.visibleCount += update
            let array = Array(current..<current+update)
            self?.updateIndex.accept(array)
        }
    }
}
