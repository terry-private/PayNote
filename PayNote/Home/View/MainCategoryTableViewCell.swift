//
//  MainCategoryTableViewCell.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/08/09.
//

import UIKit

class MainCategoryTableViewCell: UITableViewCell {
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var iconBackgroundView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var totalAmountLabel: UILabel!
    @IBOutlet private weak var statusBackBarView: UIView!
    @IBOutlet private weak var statusFrontBarView: UIView!
    @IBOutlet private weak var targetAmountLabel: UILabel!
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
