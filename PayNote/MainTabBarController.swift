//
//  MainTabBarController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/06/26.
//

import UIKit

class MainTabBarController: UITabBarController {
    var homeViewController: UIViewController {
        let vc = R.storyboard.home.homeViewController()
        return vc ?? HomeViewController()
    }

    // MARK: - ライフサイクル系
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }

    func setupTab() {
        viewControllers = [homeViewController, UIViewController(), UIViewController()]
    }
}
