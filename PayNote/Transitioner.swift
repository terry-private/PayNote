//
//  Transitioner.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/06/26.
//

import UIKit

protocol Transitioner where Self: UIViewController {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool)
    func popToRootViewController(animated: Bool)
    func popToViewController(_ viewController: UIViewController, animated: Bool)
    func present(viewController: UIViewController,
                 animated: Bool,
                 completion: (() -> ())?)
    func dismiss(animated: Bool)
}

extension Transitioner {
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard let nc = navigationController else {
            fatalError("Transitioner can't push without navigationController")
        }
        nc.pushViewController(viewController, animated: animated)
    }

    func popViewController(animated: Bool) {
    }

    func popToRootViewController(animated: Bool) {
    }

    func popToViewController(_ viewController: UIViewController, animated: Bool) {
    }

    func present(viewController: UIViewController, animated: Bool, completion: (() -> ())? = nil) {
        present(viewController, animated: animated, completion: completion)
    }

    func dismiss(animated: Bool) {
        dismiss(animated: animated)
    }
}

