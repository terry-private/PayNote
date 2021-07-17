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
    static func assembleHistoryModules() -> UIViewController
    static func assembleAccountModules() -> UIViewController
    static func assembleSettingModules() -> UIViewController
    func setupTab()
    func toAddView()
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
        guard let accountViewController = R.storyboard.home.homeViewController() else {
            fatalError("Can't create AccountViewController")
        }
        let bar = UITabBarItem(title: R.string.localizable.mainTabBar_account(), image: UIImage(systemName: "creditcard"), tag: 0)
        bar.accessibilityIdentifier = "account_bar_item"
        accountViewController.tabBarItem = bar
        return accountViewController
    }

    static func assembleSettingModules() -> UIViewController {
        // TODO: 一旦HomeViewになってます。
        guard let settingViewController = R.storyboard.home.homeViewController() else {
            fatalError("Can't create SettingViewController")
        }
        let bar = UITabBarItem(title: R.string.localizable.mainTabBar_setting(), image: UIImage(systemName: "gear"), tag: 0)
        bar.accessibilityIdentifier = "setting_bar_item"
        settingViewController.tabBarItem = bar
        return settingViewController
    }
    
    static func assembleAddModules() -> UIViewController {
        return UIViewController()
    }

    func setupTab() {
        guard let tab = tab else {
            return
        }
        tab.setViewControllers(viewControllers: [
            Self.assembleHomeModules(),
            Self.assembleHistoryModules(),
            Self.assembleAccountModules(),
            Self.assembleSettingModules()
        ])
    }
    
    func toAddView() {
        tab?.present(viewController: Self.assembleAddModules(), animated: true, completion: nil)
    }
}
