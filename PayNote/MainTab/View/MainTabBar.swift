//
//  MainTabBar.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/04.
//

import UIKit

protocol MainTabDelegate: AnyObject {
    func tappedPlusButton()
    func tappedTabButton(from: Int, to: Int)
}

class MainTabBar: UIView {
    // MARK: - IBOutlet系
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var visibleBackView: UIView!
    @IBOutlet private weak var homeButton: MainTabBarItem!
    @IBOutlet private weak var historyButton: MainTabBarItem!
    @IBOutlet private weak var accountButton: MainTabBarItem!
    @IBOutlet private weak var settingButton: MainTabBarItem!
    
    // MARK: - 変数
    lazy var buttons = [
        homeButton,
        historyButton,
        accountButton,
        settingButton
    ]
    
    private var currentIndex: Int = 0 {
        didSet {
            if oldValue == currentIndex {
                return
            }
            buttons[oldValue]!.color = .lightGray
            buttons[currentIndex]?.color = ColorManager.shared.theme.tint
            delegate?.tappedTabButton(from: oldValue, to: currentIndex)
        }
    }

    weak var delegate: MainTabDelegate?

    // MARK: - IBAction系
    @IBAction private func tappedPlusButton(_ sender: Any) {
        delegate?.tappedPlusButton()
    }
    @IBAction private func tappedHomeButton(_ sender: Any) {
        currentIndex = 0
    }
    @IBAction private func tappedHistoryButton(_ sender: Any) {
        currentIndex = 1
    }
    @IBAction private func tappedAccountButton(_ sender: Any) {
        currentIndex = 2
    }
    @IBAction private func tappedSettingButton(_ sender: Any) {
        currentIndex = 3
    }

    // MARK: - 関数
    func setup() {
        // setup center plusButton
        plusButton.layer.cornerRadius = plusButton.bounds.width / 2
        plusButton.layer.borderWidth = 0.5
        plusButton.layer.borderColor = UIColor.separator.cgColor
        plusButton.tintColor = ColorManager.shared.theme.tint
        plusButton.backgroundColor = ColorManager.shared.theme.background

        // setup tabButtons
        homeButton.setupView(icon: UIImage(systemName: "house")!, title: R.string.localizable.mainTabBar_home())
        historyButton.setupView(icon: UIImage(systemName: "note.text")!, title: R.string.localizable.mainTabBar_history())
        accountButton.setupView(icon: UIImage(systemName: "creditcard")!, title: R.string.localizable.mainTabBar_account())
        settingButton.setupView(icon: UIImage(systemName: "gearshape")!, title: R.string.localizable.mainTabBar_setting())

        visibleBackView.layer.borderWidth = 0.3
        visibleBackView.layer.borderColor = UIColor.separator.cgColor
        homeButton.color = ColorManager.shared.theme.tint
    }
    
    // カラーモード変更時に呼ばれる
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        plusButton.layer.borderColor = UIColor.separator.cgColor
        visibleBackView.layer.borderColor = UIColor.separator.cgColor
    }
}
