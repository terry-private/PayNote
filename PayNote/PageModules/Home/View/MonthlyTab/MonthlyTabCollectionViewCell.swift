//
//  MonthlyTabCollectionViewCell.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/30.
//

import UIKit

class MonthlyTabCollectionViewCell: UICollectionViewCell {
    static let cellSize = CGSize(width: Const.MonthlyTag.cellWidth, height: Const.MonthlyTag.cellHeight)
    @IBOutlet private weak var yearMonthLabel: UILabel!
    // MARK: - Class Function

    // カテゴリー表示用の下線の幅を算出する
    class func calculateCategoryUnderBarWidthBy(title: String) -> CGFloat {

        // テキストの属性を設定する
        var categoryTitleAttributes = [NSAttributedString.Key: Any]()
        categoryTitleAttributes[NSAttributedString.Key.font] = UIFont.preferredFont(forTextStyle: .headline)

        // 引数で渡された文字列とフォントから配置するラベルの幅を取得する
        let categoryTitleLabelSize = CGSize(
            width: .greatestFiniteMagnitude,
            height: Const.MonthlyTag.fontHeight
        )
        let categoryTitleLabelRect = title.boundingRect(
            with: categoryTitleLabelSize,
            options: .usesLineFragmentOrigin,
            attributes: categoryTitleAttributes,
            context: nil)

        return ceil(categoryTitleLabelRect.width)
    }

    func setYearMonth(yearMonth: YearMonth, isSelected: Bool = false) {
        yearMonthLabel.text = yearMonth.description
        yearMonthLabel.textColor = isSelected ? ColorManager.shared.theme.text : ColorManager.shared.theme.text2
    }
}