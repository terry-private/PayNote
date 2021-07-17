//
//  HistoryPresenter.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/17.
//

import Foundation

protocol HistoryPresenterProtocol: AnyObject {
    var view: HistoryViewProtocol? { get set }
}

final class HistoryPresenter: HistoryPresenterProtocol {
    weak var view: HistoryViewProtocol?
}
