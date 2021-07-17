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

    }
}

extension MainTabBarController: MainTabDelegate {
    func tappedPlusButton() {
        
    }
    
    func tappedTabButton(from: Int, to: Int) {
        
    }
    
    
}
