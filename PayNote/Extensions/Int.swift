//
//  Int.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/31.
//

import Foundation

private let formatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.groupingSeparator = ","
    numberFormatter.groupingSize = 3
    return numberFormatter
}()

extension Int {
    var withComma: String {
        formatter.string(from: NSNumber(integerLiteral: self)) ?? "\(self)"
    }
}
