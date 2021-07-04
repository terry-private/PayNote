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
            fatalError("Can't create HomeViewController")
        }
        let bar = UITabBarItem(title: R.string.localizable.mainTabBar_home(), image: UIImage(systemName: "house"), tag: 0)
        bar.accessibilityIdentifier = "home_bar_item"
        homeViewController.tabBarItem = bar
        return homeViewController
    }

    static func assembleHistoryModules() -> UIViewController {
        // TODO: 一旦HomeViewになってます。
        guard let historyViewController = R.storyboard.home.homeViewController() else {
            fatalError("Can't create HistoryViewController")
        }
        let bar = UITabBarItem(title: R.string.localizable.mainTabBar_history(), image: UIImage(systemName: "book"), tag: 0)
        bar.accessibilityIdentifier = "history_bar_item"
        historyViewController.tabBarItem = bar
        return historyViewController
    }

    static func assembleAccountModules() -> UIViewController {
        // TODO: 一旦HomeViewになってます。
        guard let historyViewController = R.storyboard.home.homeViewController() else {
            fatalError("Can't create AccountViewController")
        }
        let bar = UITabBarItem(title: R.string.localizable.mainTabBar_account(), image: UIImage(systemName: "creditcard"), tag: 0)
        bar.accessibilityIdentifier = "account_bar_item"
        historyViewController.tabBarItem = bar
        return historyViewController
    }

    func setupTab() {
        guard let tab = tab else {
            return
        }
        tab.setViewControllers(viewControllers: [
            Self.assembleHomeModules(),
            Self.assembleHistoryModules(),
            Self.assembleAccountModules()
        ])
    }
}
