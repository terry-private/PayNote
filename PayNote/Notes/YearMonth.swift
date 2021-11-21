//
//  YearMonth.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/19.
//

import Foundation

struct YearMonth: Hashable {
    // MARK: - Stored Property
    let value: Int

    // MARK: - Computed Property
    var year: Int {
        value / 12// - (value % 12 == 0 ? 1 : 0)
    }
    var month: Int {
        value % 12 + 1
    }

    // MARK: - init
    init(value: Int) {
        self.value = value
    }
    init(year: Int, month: Int) {
        value = year * 12 + month - 1
    }
    init(_ date: Date) {
        let year = Calendar.getYear(from: date)
        let month = Calendar.getMonth(from: date)
        value = year * 12 + month - 1
    }
}

// MARK: - CustomStringConvertible
extension YearMonth: CustomStringConvertible {
    var description: String {
        "\(year)年\(month)月"
    }
}

// MARK: - Comparable
extension YearMonth: Comparable {
    static func < (lhs: YearMonth, rhs: YearMonth) -> Bool {
        lhs.value < rhs.value
    }
}
