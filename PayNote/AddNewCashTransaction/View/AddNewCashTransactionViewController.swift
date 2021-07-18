//
//  AddNewCashTransactionViewController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/18.
//

import UIKit

protocol AddNewCashTransactionViewProtocol: Transitioner {
    var presenter: AddNewCashTransactionPresenterProtocol? { get set }
}

class AddNewCashTransactionViewController: UIViewController, AddNewCashTransactionViewProtocol {
    var presenter: AddNewCashTransactionPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

