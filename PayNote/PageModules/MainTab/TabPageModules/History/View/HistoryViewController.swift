//
//  HistoryViewController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/17.
//

import UIKit

protocol HistoryViewProtocol: Transitioner {
    var presenter: HomePresenterProtocol? { get set }
}

class HistoryViewController: UIViewController, HistoryViewProtocol {
    var presenter: HomePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
