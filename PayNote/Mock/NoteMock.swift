//
//  NoteMock.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/17.
//

import Foundation

class NoteMock {
    
    static let bankId1 = UUID()
    static let bankId2 = UUID()
    static let bankId3 = UUID()
    
    static let mainCategoryId1 = UUID()
    static let mainCategoryId2 = UUID()
    static let mainCategoryId3 = UUID()
    
    static let subCategoryId11 = UUID()
    static let subCategoryId12 = UUID()
    
    static let cashTransactionId111 = UUID()
    static let cashTransactionId112 = UUID()
    static let cashTransactionId121 = UUID()
    static let cashTransactionId122 = UUID()
    
    static let thisMonth = Date()
    static let lastMonth = Date()
    
    class func create() {
        createBanks()
        createMainCategories()
        createSubCategories()
        createCashTransactions()
    }
    static var randomCTMemo: String {
        return ["食材","消耗品", "酒", "ベビー用品", "子供服", "下着類", "おやつ", "まとめ買い系", "備品"].randomElement() ?? ""
    }
    
    
    private static func createBanks() {
        Cache.banks[bankId1] = BankEntity(
            id: bankId1,
            name: "三井住友【生活費用】",
            memo: "",
            createdAt: Date(),
            updatedAt: Date()
        )
        Cache.banks[bankId2] = BankEntity(
            id: bankId2,
            name: "家族の財布【生活費用】",
            memo: "",
            createdAt: Date(),
            updatedAt: Date()
        )
        Cache.banks[bankId3] = BankEntity(
            id: bankId3,
            name: "ゆうちょ【貯金用】",
            memo: "",
            createdAt: Date(),
            updatedAt: Date()
        )
    }
    
    private static func createMainCategories() {
        Cache.mainCategories[mainCategoryId1] = MainCategoryEntity(
            id: mainCategoryId1,
            name: "生活費",
            inOut: .outgo,
            targetAmount: 50000,
            memo: "",
            createdAt: Date(),
            updatedAt: Date()
        )
        Cache.mainCategories[mainCategoryId2] = MainCategoryEntity(
            id: mainCategoryId2,
            name: "固定費",
            inOut: .outgo,
            targetAmount: 100000,
            memo: "",
            createdAt: Date(),
            updatedAt: Date()
        )
        Cache.mainCategories[mainCategoryId3] = MainCategoryEntity(
            id: mainCategoryId3,
            name: "収入",
            inOut: .income,
            targetAmount: 250000,
            memo: "",
            createdAt: Date(),
            updatedAt: Date()
        )
    }
    
    private static func createSubCategories() {
        Cache.subCategories[subCategoryId11] = SubCategoryEntity(
            id: subCategoryId11,
            mainCategoryId: mainCategoryId1,
            name: "スーパー",
            memo: "",
            createdAt: Date(),
            updatedAt: Date()
        )
        Cache.subCategories[subCategoryId12] = SubCategoryEntity(
            id: subCategoryId12,
            mainCategoryId: mainCategoryId1,
            name: "ネット",
            memo: "",
            createdAt: Date(),
            updatedAt: Date()
        )
    }
    
    private static func createCashTransactions() {
        Cache.cashTransactions[cashTransactionId111] = CashTransactionEntity(
            id: cashTransactionId111,
            amount: 4800,
            subCategoryId: subCategoryId11,
            bankId: bankId2,
            date: Date(),
            memo: "",
            createdAt: Date(),
            updatedAt: Date()
        )
        Cache.cashTransactions[cashTransactionId112] = CashTransactionEntity(
            id: cashTransactionId112,
            amount: 1850,
            subCategoryId: subCategoryId11,
            bankId: bankId1,
            date: Date(),
            memo: "",
            createdAt: Date(),
            updatedAt: Date()
        )
        Cache.cashTransactions[cashTransactionId121] = CashTransactionEntity(
            id: cashTransactionId121,
            amount: 8800,
            subCategoryId: subCategoryId12,
            bankId: bankId1,
            date: Date(),
            memo: "amazonで本棚",
            createdAt: Date(),
            updatedAt: Date()
        )
        Cache.cashTransactions[cashTransactionId122] = CashTransactionEntity(
            id: cashTransactionId122,
            amount: 5200,
            subCategoryId: subCategoryId12,
            bankId: bankId1,
            date: Date(),
            memo: "楽天でスキンケア",
            createdAt: Date(),
            updatedAt: Date()
        )
    }
}

