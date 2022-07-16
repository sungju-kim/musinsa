//
//  MainViewModel.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import Foundation

final class MainViewModel {
    let didLoadData = PublishRelay<[Section]>()
    let loadData = PublishRelay<Void>()

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
                    self?.didLoadData.accept(entity.toDomain())
                case .failure(let error):
                    // MARK: - TODO Error Handling
                    _ = error
                }
            }
        }
    }
}
