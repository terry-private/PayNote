//
//  YearMonth.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/19.
//

import Foundation

struct YearMonth: Hashable {
    let key: Int
    let year: Int
    let month: Int

    // MARK: - init
    init(key: Int) {
        self.key = key
        month = key % 12
        year = key / 12
    }
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        key = year * 12 + month
    }
    init(_ date: Date) {
        year = date.year
        month = date.month
        key = year * 12 + month
    }
}

extension YearMonth: CustomStringConvertible {
    var description: String {
        "\(year)年\(month)月"
    }
}
