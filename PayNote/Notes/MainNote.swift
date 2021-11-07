//
//  MainNote.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/19.
//

import Foundation

class MainNote {
    let id: UUID

    init(id: UUID) {
        self.id = id
    }

    var subNotes = [UUID: SubNote]()

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
        for subNote in subNotes.values {
            totalCache += subNote.total
        }
        shouldCalc = false
    }

    // MARK: - Read From Entity
    var name: String { PayNote.mainCategories[id]!.name }
    var inOut: InOut { PayNote.mainCategories[id]!.inOut }
    var targetAmount: Int { PayNote.mainCategories[id]!.targetAmount }
    var memo: String { PayNote.mainCategories[id]!.memo }
    var createdAt: Date { PayNote.mainCategories[id]!.createdAt }
    var updatedAt: Date { PayNote.mainCategories[id]!.updatedAt }
}
