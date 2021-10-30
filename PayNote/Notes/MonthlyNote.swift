//
//  MonthlyNote.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/19.
//

import Foundation

class MonthlyNote {
    let yearMonth: YearMonth

    init(yearMonth: YearMonth) {
        self.yearMonth = yearMonth
    }

    var mainNotes = [UUID: MainNote]()

    var balance: Int { income - outgo }

    private var shouldCalc: Bool = true

    // income
    private var incomeCache: Int = 0
    var income: Int {
        if shouldCalc {
            calc()
        }
        return incomeCache
    }

    // outgo
    private var outgoCache: Int = 0
    var outgo: Int {
        if shouldCalc {
            calc()
        }
        return outgoCache
    }

    private func calc() {
        incomeCache = 0
        outgoCache = 0
        for mainNote in mainNotes.values {
            switch mainNote.inOut {
            case .income:
                incomeCache += mainNote.total
            case .outgo:
                outgoCache += mainNote.total
            }
        }
        shouldCalc = false
    }
}
