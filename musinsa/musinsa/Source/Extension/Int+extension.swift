//
//  String+extension.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import Foundation

extension Int {
    func decimalWon() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let result = numberFormatter.string(from: NSNumber(value: self)) else { return "" }

        return "\(result)원"
    }
}
