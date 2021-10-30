//
//  AccountViewController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/17.
//

import UIKit

protocol AccountViewProtocol: Transitioner {
    var presenter: AccountPresenterProtocol? { get set }
}

class AccountViewController: UIViewController, AccountViewProtocol {
    var presenter: AccountPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
