//
//  SettingViewController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/18.
//

import UIKit

protocol SettingViewProtocol: Transitioner {
    var presenter: SettingPresenterProtocol? { get set }
}

class SettingViewController: UIViewController, SettingViewProtocol {
    var presenter: SettingPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
