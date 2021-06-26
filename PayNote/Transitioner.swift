//
//  Transitioner.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/06/26.
//

import UIKit

protocol Transitioner: AnyObject {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool)
    func popToViewController(_ viewController: UIViewController, animated: Bool)
    func popToRootViewController(animated: Bool)
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension Transitioner where Self: UIViewController {
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard let navigationController = navigationController else {
            fatalError("Transitioner can't push without navigationController")
        }
        navigationController.pushViewController(viewController, animated: animated)
    }

    func popViewController(animated: Bool) {
        guard let navigationController = navigationController else {
            return
        }
        navigationController.popViewController(animated: animated)
    }

    func popToRootViewController(animated: Bool) {
        guard let navigationController = navigationController else {
            return
        }
        navigationController.popToRootViewController(animated: animated)
    }

    func popToViewController(_ viewController: UIViewController, animated: Bool) {
        guard let navigationController = navigationController else {
            return
        }
        navigationController.popToViewController(viewController, animated: animated)
    }

    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        present(viewController, animated: animated, completion: completion)
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        dismiss(animated: animated, completion: completion)
    }
}
