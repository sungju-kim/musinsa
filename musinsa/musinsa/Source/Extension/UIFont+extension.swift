//
//  UIFont+extension.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import UIKit.UIFont

extension UIFont {
    enum SFProDisplay {
        static let bold: (CGFloat) -> UIFont? = { (size) in
            return UIFont(name: "SFProDisplay-Bold", size: size)
        }

        static let semiBold: (CGFloat) -> UIFont? = { (size) in
            return UIFont(name: "SFProDisplay-Semibold", size: size)
        }

        static let regular: (CGFloat) -> UIFont? = { (size) in
            return UIFont(name: "SFProDisplay-Regular", size: size)
        }
    }
}
