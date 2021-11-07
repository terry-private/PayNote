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
        year = key / 12
        month = key % 12
    }
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        key = year * 12 + month
    }
    init(_ date: Date) {
        year = Calendar.getYear(from: date)
        month = Calendar.getMonth(from: date)
        key = year * 12 + month
    }
}

extension YearMonth: CustomStringConvertible {
    var description: String {
        "\(year)年\(month)月"
    }
}

extension YearMonth: Comparable {
    static func < (lhs: YearMonth, rhs: YearMonth) -> Bool {
        lhs.key < lhs.key
    }
}
