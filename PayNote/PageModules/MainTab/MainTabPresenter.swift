//
//  MainTabPresenter.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/06/26.
//

import Foundation

protocol MainTabPresenterProtocol: AnyObject {
    var tab: MainTabBarProtocol? { get set }
    var router: MainTabRouterProtocol? { get set }
    func viewDidAppear()
    func tappedPlusButton()
    func tappedTabButton(from: Int, to: Int)
}

final class MainTabPresenter: MainTabPresenterProtocol {
    weak var tab: MainTabBarProtocol?
    var router: MainTabRouterProtocol?
    func viewDidAppear() {
        guard let router = router else {
            return
        }
        router.setupTab()
    }
    func tappedPlusButton() {
        router?.toAddView()
    }
    func tappedTabButton(from: Int, to: Int) {
        router?.tappedTabButton(from: from, to: to)
    }
}
