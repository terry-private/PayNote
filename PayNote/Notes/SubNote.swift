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
            totalCache += Cache.cashTransactions[uuid]!.amount
        }
        shouldCalc = false
    }

    // MARK: - Read From Entity
    var mainCategoryId: UUID { Cache.subCategories[id]!.mainCategoryId }
    var name: String { Cache.subCategories[id]!.name }
    var memo: String { Cache.subCategories[id]!.memo }
    var createdAt: Date { Cache.subCategories[id]!.createdAt }
    var updatedAt: Date { Cache.subCategories[id]!.updatedAt }
}
