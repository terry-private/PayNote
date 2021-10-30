//
//  MonthlyHeaderCollectionReusableView.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/17.
//

import UIKit

class MonthlyContentHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var incomeAmountLabel: UILabel!
    @IBOutlet weak var outgoAmountLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
