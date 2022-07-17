//
//  ScrollViewModel.swift
//  musinsa
//
//  Created by dale on 2022/07/17.
//

import Foundation

final class ScrollViewModel: SectionViewModel {
    private var contents: [CellModelable]
    private(set) var headerViewModel: HeaderViewModel?
    private(set) var footerViewModel: FooterViewModel?

    private var visibleCount: Int = 4
    var count: Int {
        return visibleCount
    }

    let refeshTapped = PublishRelay<Void>()
    
    subscript(_ index: Int) -> CellModelable? {
        return contents[index]
    }

    init(section: Section) {
        self.contents = section.contents.data
        headerViewModel = HeaderViewModel(header: section.header)
        footerViewModel = FooterViewModel(footer: section.footer)
        bind()
    }
}

// MARK: - Bind

extension ScrollViewModel {
    func bind() {
        footerViewModel?.tappedRefresh.bind(onNext: {[weak self] _ in
            self?.contents.shuffle()
            self?.refeshTapped.accept(())
        })
    }
}
