//
//  ColorManager.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/05.
//

import UIKit

enum ColorTheme {
    case os, main
    var background: UIColor {
        switch self {
        case .os:
            return .systemBackground
        case .main:
            return R.color.mainBackGround() ?? Self.os.background
        }
    }
    var header: UIColor {
        switch self {
        case .os:
            return .secondarySystemGroupedBackground
        case .main:
            return R.color.mainHeader() ?? Self.os.header
        }
    }
    var selected: UIColor {
        switch self {
        case .os:
            return .systemFill
        case .main:
            return R.color.mainSelected() ?? Self.os.selected
        }
    }
    var text: UIColor {
        switch self {
        case .os:
            return .label
        case .main:
            return R.color.mainText()!
        }
    }
    var text2: UIColor {
        switch self {
        case .os:
            return .secondaryLabel
        case .main:
            return R.color.mainText2()!
        }
    }
    var tint: UIColor {
        switch self {
        case .os:
            return .systemBlue
        case .main:
            return .systemBlue
        }
    }
}

final class ColorManager {
    var theme: ColorTheme
    private init() {
        theme = .main
    }
    static let shared = ColorManager()
}
