//
//  DomainConvertable.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import Foundation

protocol DomainConvertable {
    associatedtype DomainType
    func toDomain() -> DomainType
}
