//
//  UILabel+extention.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import UIKit.UILabel

extension UILabel {
    static func makeCustomLabel(_ text: String? = "", _ font: UIFont?, _ color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        return label
    }
}
