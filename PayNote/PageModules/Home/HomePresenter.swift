//
//  HomePresenter.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/06/27.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
}

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
}
