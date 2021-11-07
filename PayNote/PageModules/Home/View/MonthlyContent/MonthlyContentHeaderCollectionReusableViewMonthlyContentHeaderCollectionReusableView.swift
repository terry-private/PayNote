//
//  MonthlyHeaderCollectionReusableView.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/17.
//

import UIKit

final class MonthlyContentHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var incomeAmountLabel: UILabel!
    @IBOutlet private weak var outgoAmountLabel: UILabel!

    var monthlyNote: MonthlyNote? {
        didSet {
            balanceLabel.text = monthlyNote?.balance.withComma
            incomeAmountLabel.text = monthlyNote?.income.withComma
            outgoAmountLabel.text = monthlyNote?.outgo.withComma
        }
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
