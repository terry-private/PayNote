//
//  MainTabBarItem.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/17.
//

import UIKit

class MainTabBarItem: UIButton {
    var color = UIColor.lightGray {
        didSet {
            iconImageView.tintColor = color
            textLabel.textColor = color
        }
    }
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .lightGray
        return imageView
    }()
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    func setupView(icon: UIImage, title: String) {
        translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
        textLabel.text = title
        textLabel.font = .preferredFont(forTextStyle: .caption2)
        addSubview(iconImageView)
        addSubview(textLabel)
        iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1, constant: 0).isActive = true
        let iconBottomConstant: CGFloat = textLabel.text!.isEmpty ? -3 : -19
        iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: iconBottomConstant).isActive = true

        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
