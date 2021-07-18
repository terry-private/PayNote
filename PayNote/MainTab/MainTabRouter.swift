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

    
    static func assembleHomeModules() -> UIViewController {
        guard let homeViewController = R.storyboard.home.homeViewController() else {
            fatalError("Can't create HomeViewController")
        }
        return homeViewController
    }

    static func assembleHistoryModules() -> UIViewController {
        guard let historyViewController = R.storyboard.history.historyViewController() else {
            fatalError("Can't create HistoryViewController")
        }
        historyViewController.view.backgroundColor = .systemBlue
        return historyViewController
    }

    static func assembleAccountModules() -> UIViewController {
        guard let accountViewController = R.storyboard.account.accountViewController() else {
            fatalError("Can't create AccountViewController")
        }
        accountViewController.view.backgroundColor = .systemRed
        return accountViewController
    }

    static func assembleSettingModules() -> UIViewController {
        guard let settingViewController = R.storyboard.setting.settingViewController() else {
            fatalError("Can't create SettingViewController")
        }
        settingViewController.view.backgroundColor = .systemYellow
        return settingViewController
    }

    static func assembleAddNewCashTransactionModules() -> UIViewController {
        guard let addNewCashTransactionViewController = R.storyboard.addNewCashTransaction.addNewCashTransactionViewController() else {
            fatalError("Can't create AddNewCashTransactionViewController")
        }
        addNewCashTransactionViewController.view.backgroundColor = .systemGreen
        return addNewCashTransactionViewController
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
        tab?.present(viewController: Self.assembleAddNewCashTransactionModules(), animated: true, completion: nil)
    }
}
