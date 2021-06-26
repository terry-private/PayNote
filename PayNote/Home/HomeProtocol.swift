//
//  HomeProtocol.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/06/26.
//

import Foundation

protocol HomeViewProtocol: Transitioner {
    var presenter: HomePresenterProtocol? { get set }
}

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
}
