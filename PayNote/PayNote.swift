//
//  PayNote.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/17.
//

import Foundation

enum PayNote {
    static var mainCategories = [UUID: MainCategoryEntity]()
    static var subCategories = [UUID: SubCategoryEntity]()
    static var cashTransactions = [UUID: CashTransactionEntity]()
    static var banks = [UUID: BankEntity]()

    static var monthlyNotes = [YearMonth: MonthlyNote]()

    /// init of monthlyNotes by entities
    static func refreshNote() {
        for cashTransaction in cashTransactions.values {
            let subId = cashTransaction.subCategoryId
            let mainId = subCategories[subId]!.mainCategoryId
            let yearMonth = YearMonth(cashTransaction.date)
            firstYearMonth = min(firstYearMonth, yearMonth)
            let monthlyNote = monthlyNotes[yearMonth, default: MonthlyNote(yearMonth: yearMonth)]
            let mainNote = monthlyNote.mainNotes[mainId, default: MainNote(id: mainId)]
            let subNote = mainNote.subNotes[subId, default: SubNote(id: subId)]
            subNote.cashTransactions.insert(cashTransaction.id)
            mainNote.subNotes[subNote.id] = subNote
            monthlyNote.mainNotes[mainNote.id] = mainNote
            monthlyNotes[monthlyNote.yearMonth] = monthlyNote
        }
    }

    private(set) static var firstYearMonth = YearMonth(Date())
}
