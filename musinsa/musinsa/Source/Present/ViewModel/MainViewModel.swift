//
//  MainViewModel.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import Foundation

final class MainViewModel {
    let didLoadData = PublishRelay<[SectionViewModel]>()
    let loadData = PublishRelay<Void>()

    let insertItem = PublishRelay<[IndexPath]>()
    let refreshItem = PublishRelay<Int>()

    init() {
        bind()
    }
}

// MARK: - Bind

private extension MainViewModel {
    func bind() {
        loadData.bind {_ in
            NetworkManager.shared.request(endPoint: MusinsaEndPoint.main) { [weak self] (result: Result<ProductsEntity, NetworkError>) in
                switch result {
                case .success(let entity):
                    let viewModels = entity.toDomain().enumerated().map { index, section -> SectionViewModel in
                        switch section.contents.type {
                        case .grid:
                            let viewModel = GridViewModel(section: section)
                            viewModel.updateIndex.bind { newArray in
                                self?.insertItem.accept(newArray.map {IndexPath(item: $0, section: index) })
                            }
                            return viewModel
                        case .banner:
                            return BannerViewModel(section: section)
                        case .scroll:
                            let viewModel = ScrollViewModel(section: section)
                            viewModel.refeshTapped.bind {[weak self] _ in
                                self?.refreshItem.accept(index)
                            }
                            return viewModel
                        case .style:
                            let viewModel = StyleViewModel(section: section)
                            viewModel.updateIndex.bind { newArray in
                                self?.insertItem.accept(newArray.map { IndexPath(item: $0, section: index) })
                            }
                            return viewModel
                        }
                    }
                    self?.didLoadData.accept(viewModels)
                case .failure(let error):
                    // MARK: - TODO Error Handling
                    _ = error
                }
            }
        }
    }
}
