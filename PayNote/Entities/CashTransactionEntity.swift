//
//  CashTransactionEntity.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/31.
//

import Foundation

struct CashTransactionEntity {
    let id: UUID
    let amount: Int
    let subCategoryId: UUID
    let bankId: UUID
    let date: Date
    let memo: String
    let createdAt: Date
    let updatedAt: Date
}
