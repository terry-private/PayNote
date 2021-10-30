//
//  AccountPresenter.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/17.
//

import Foundation

protocol AccountPresenterProtocol: AnyObject {
    var view: AccountViewProtocol? { get set }
}

final class AccountPresenter: AccountPresenterProtocol {
    weak var view: AccountViewProtocol?
}
