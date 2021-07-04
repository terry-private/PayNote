//
//  MainTabBarController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/06/26.
//

import UIKit

protocol MainTabBarProtocol: Transitioner {
    var presenter: MainTabPresenterProtocol? { get set }
    func setViewControllers(viewControllers: [UIViewController])
}

final class MainTabBarController: UITabBarController, MainTabBarProtocol {
    var presenter: MainTabPresenterProtocol?

    convenience init(presenter: MainTabPresenter) {
        self.init()
        self.presenter = presenter
    }
    // MARK: - ライフサイクル系
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemRed
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }

    func setViewControllers(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}
