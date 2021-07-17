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
    var mainTabBar: MainTabBar?

    // MARK: - ライフサイクル系
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTabBar = R.nib.mainTabBar(owner: view)
        view.addSubview(mainTabBar!)
        tabBar.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }

    func setViewControllers(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
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

        mainTabBar?.setup()
        mainTabBar?.delegate = self
    }
}

extension MainTabBarController: MainTabDelegate {
    func tappedPlusButton() {
        presenter?.tappedPlusButton()
    }

    func tappedTabButton(from: Int, to: Int) {
        presenter?.tappedTabButton(from: from, to: to)
        guard let fromController = viewControllers?[from],
              let toController = viewControllers?[to] else { return }
        let fromView = fromController.view!
        let toView = toController.view!
        let viewSize = fromView.frame
        fromView.superview?.addSubview(toView)
        toView.frame = CGRect(x: 0, y: viewSize.origin.y, width: UIScreen.main.bounds.width, height: viewSize.height)
        fromView.removeFromSuperview()
    }
}