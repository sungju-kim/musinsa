//
//  CustomObservable.swift
//  musinsa
//
//  Created by dale on 2022/07/16.
//

import Foundation

final class PublishRelay<T> {
    typealias Element = (T) -> Void

    private var binders: [Element] = []

    func bind(onNext: @escaping Element) {
        binders.append(onNext)
    }

    func accept(_ value: T) {
        binders.forEach {
            $0(value)
        }
    }

    func dispose() {
        binders.removeAll()
    }
}

final class BehaviorRelay<T> {
    typealias Element = (T) -> Void

    private var binders: [Element] = []
    private(set) var value: T

    init(value: T) {
        self.value = value
    }

    func bind(onNext: @escaping Element) {
        onNext(value)
        binders.append(onNext)
    }

    func accept(_ value: T) {
        self.value = value
        binders.forEach {
            $0(value)
        }
    }

    func dispose() {
        binders.removeAll()
    }
}
