//
//  AddNewCashTransactionPresenter.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/18.
//

import Foundation

protocol AddNewCashTransactionPresenterProtocol: AnyObject {
    var view: AddNewCashTransactionViewProtocol? { get set }
}

final class AddNewCashTransactionPresenter: AddNewCashTransactionPresenterProtocol {
    weak var view: AddNewCashTransactionViewProtocol?
}
