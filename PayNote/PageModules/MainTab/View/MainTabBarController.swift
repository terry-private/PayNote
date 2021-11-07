//
//  MainTabBarController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/06/26.
//

import UIKit

protocol MainTabBarProtocol: Transitioner {
    var presenter: MainTabPresenterProtocol? { get set }
    var viewControllers: [UIViewController]? { get set }
}

final class MainTabBarController: UITabBarController, MainTabBarProtocol {
    var presenter: MainTabPresenterProtocol?
    var mainTabBar: MainTabBar?

    // MARK: - ライフサイクル系
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTabBar = R.nib.mainTabBar(owner: view)
        view.addSubview(mainTabBar!)
        mainTabBar?.delegate = self
        tabBar.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setMainTabBar()
    }

    func setMainTabBar() {
        mainTabBar?.translatesAutoresizingMaskIntoConstraints = false
        mainTabBar?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainTabBar?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainTabBar?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTabBar?.heightAnchor.constraint(equalToConstant: view.safeAreaInsets.bottom + 64).isActive = true
        mainTabBar?.setPlusButtonBottomConstraint(constant: view.safeAreaInsets.bottom / 2)
        mainTabBar?.setup()
    }
}

extension MainTabBarController: MainTabDelegate {
    func tappedPlusButton() {
        presenter?.tappedPlusButton()
    }

    func tappedTabButton(from: Int, to: Int) {
        presenter?.tappedTabButton(from: from, to: to)
    }
}
