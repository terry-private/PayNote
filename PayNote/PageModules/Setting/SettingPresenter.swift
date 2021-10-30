//
//  SettingPresenter.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/18.
//

import Foundation

protocol SettingPresenterProtocol: AnyObject {
    var view: SettingViewProtocol? { get set }
}

final class SettingPresenter: SettingPresenterProtocol {
    weak var view: SettingViewProtocol?
}
