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
    var shouldCalc: Bool = true
    var totalCache = 0
    var total: Int {
        get {
            if shouldCalc {
                calc()
            }
            return totalCache
        }
    }
    private func calc() {
        totalCache = 0
        for subNote in subNotes.values {
            totalCache += subNote.total
        }
        shouldCalc = false
    }
    
    // MARK: - Read From Entity
    var name: String { Cache.mainCategories[id]!.name }
    var inOut: InOut { Cache.mainCategories[id]!.inOut }
    var targetAmount: Int { Cache.mainCategories[id]!.targetAmount }
    var memo: String { Cache.mainCategories[id]!.memo }
    var createdAt: Date { Cache.mainCategories[id]!.createdAt }
    var updatedAt: Date { Cache.mainCategories[id]!.updatedAt }
}
