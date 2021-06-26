//
//  MainTabBarController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/06/26.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK:- ライフサイクル系
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }

    func setupTab() {
        viewControllers = [UIViewController(), UIViewController(), UIViewController()]
    }
}
