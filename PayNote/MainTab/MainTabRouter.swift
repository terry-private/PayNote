//
//  MainTabRouter.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/06/27.
//

import UIKit

protocol MainTabRouterProtocol: AnyObject {
    var tab: MainTabBarProtocol? { get set }
    static func assembleHomeModules() -> UIViewController
    func setupTab()
}

final class MainTabRouter: MainTabRouterProtocol {
    weak var tab: MainTabBarProtocol?

    /// make HomeViewController & DI
    /// - HomePresenter
    ///     - HomeRouter
    ///     - HomeInteractor
    /// - Returns: HomeViewController
    static func assembleHomeModules() -> UIViewController {
        guard let homeViewController = R.storyboard.home.homeViewController() else {
            fatalError("Unexpected nil @\(#function): \(#line)")
        }
        let bar = UITabBarItem(title: R.string.localizable.mainTabBar_home(), image: UIImage(systemName: "house"), tag: 0)
        bar.accessibilityIdentifier = "articleList_bar"
        homeViewController.tabBarItem = bar
        return homeViewController
    }

    func setupTab() {
        guard let tab = tab else {
            return
        }
        tab.setViewControllers(viewControllers: [
            Self.assembleHomeModules()
        ])
    }
}
