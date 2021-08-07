//
//  CashTransactionEntity.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/31.
//

import Foundation

struct CashTransactionEntity {
    let id: UUID
    let inOut: InOut
    let amount: Int
    let subCategoryId: String
    let bankId: String
    let date: Date
    let memo: String
}
