//
//  MainViewController.swift
//  musinsa
//
//  Created by dale on 2022/07/13.
//

import UIKit

class MainViewController: UIViewController {
    private var domain: Products?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Providing Function

extension MainViewController {
    func setDomain(with domain: Products) {
        self.domain = domain
    }
}
