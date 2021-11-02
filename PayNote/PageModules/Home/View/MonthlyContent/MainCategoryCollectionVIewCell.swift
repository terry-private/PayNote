//
//  MainCategoryCollectionViewCell.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/16.
//

import Foundation
import UIKit

class MainCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var iconBackgroundView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var totalAmountLabel: UILabel!
    @IBOutlet private weak var statusBackBarView: UIView!
    @IBOutlet private weak var statusFrontBarView: UIView!
    @IBOutlet private weak var targetAmountLabel: UILabel!
    @IBOutlet private weak var remainingAmountLabel: UILabel!
    var mainNote: MainNote? {
        didSet {
            guard let mainNote = mainNote else {
                return
            }
            nameLabel.text = mainNote.name
            totalAmountLabel.text = mainNote.total.description
            targetAmountLabel.text = mainNote.targetAmount.description
            remainingAmountLabel.text = (mainNote.total - mainNote.targetAmount).withComma
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let radius = statusBackBarView.bounds.height / 2
        cardView.layer.cornerRadius = 15
        cardView.layer.borderWidth = 0.3
        cardView.layer.borderColor = UIColor.separator.cgColor
        iconBackgroundView.layer.cornerRadius = radius
        statusBackBarView.layer.cornerRadius = radius
        statusFrontBarView.layer.cornerRadius = radius
    }
}
