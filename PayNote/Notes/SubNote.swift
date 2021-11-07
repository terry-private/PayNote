//
//  SubNote.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/19.
//

import Foundation

class SubNote {
    let id: UUID

    init(id: UUID) {
        self.id = id
    }

    var cashTransactions = Set<UUID>()

    // MARK: - total
    var shouldCalc = true
    var totalCache = 0
    var total: Int {
        if shouldCalc {
            calc()
        }
        return totalCache
    }
    private func calc() {
        totalCache = 0
        for uuid in cashTransactions {
            totalCache += PayNote.cashTransactions[uuid]!.amount
        }
        shouldCalc = false
    }

    // MARK: - Read From Entity
    var mainCategoryId: UUID { PayNote.subCategories[id]!.mainCategoryId }
    var name: String { PayNote.subCategories[id]!.name }
    var memo: String { PayNote.subCategories[id]!.memo }
    var createdAt: Date { PayNote.subCategories[id]!.createdAt }
    var updatedAt: Date { PayNote.subCategories[id]!.updatedAt }
}
