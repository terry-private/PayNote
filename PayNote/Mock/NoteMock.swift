//
//  NoteMock.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/17.
//

import Foundation

enum NoteMock {
    static func create() {
        createBanks()
        createCategories()
    }
    struct Main {
        let name: String
        let subCategories: [UUID: String]
        let banks: [(UUID, String)]
        let target: Int
        let memo: [String]
    }
    private static let bank1 = (UUID(), "三井住友【生活費用】")
    private static let bank2 = (UUID(), "家族の財布【生活費用】")
    private static let bank3 = (UUID(), "ゆうちょ【貯金用】")
    private static let banks = [bank1, bank2, bank3]

    private static let sub11 = (UUID(), "家賃", 68000)
    private static let sub12 = (UUID(), "光熱費", 20000)
    private static let sub1s = [sub11, sub12]

    private static let sub21 = (UUID(), "夫給料", 180000)
    private static let sub22 = (UUID(), "嫁給料", 100000)
    private static let sub2s = [sub21, sub22]

    private static func createBanks() {
        for bank in banks {
            PayNote.banks[bank.0] = BankEntity(
                id: bank.0,
                name: bank.1,
                memo: "",
                createdAt: Date(),
                updatedAt: Date()
            )
        }
    }
    private static let mainCategories: [UUID: Main] = [
        UUID(): Main(
            name: "生活費",
            subCategories: [UUID(): "スーパー", UUID(): "薬局"],
            banks: [bank1, bank2],
            target: 50000,
            memo: ["食材", "消耗品", "酒", "ベビー用品", "子供服", "下着類", "おやつ", "まとめ買い系", "備品"]
        ),
        UUID(): Main(
            name: "娯楽費",
            subCategories: [UUID(): "外食", UUID(): "娯楽施設"],
            banks: [bank1, bank2],
            target: 30000,
            memo: ["旅行", "梅田", "今津"]
        ),
        UUID(): Main(
            name: "固定費",
            subCategories: [sub11.0: sub11.1, sub12.0: sub12.1],
            banks: [bank1],
            target: 88000,
            memo: []
        ),
        UUID(): Main(
            name: "収入",
            subCategories: [sub21.0: sub21.1, sub22.0: sub22.1],
            banks: [bank3],
            target: 280000,
            memo: []
        )
    ]

    private static func createCategories() {
        for mId in mainCategories.keys {
            guard let main = mainCategories[mId] else { continue }
            PayNote.mainCategories[mId] = MainCategoryEntity(
                id: mId,
                name: main.name,
                inOut: main.name == "収入" ? .income : .outgo,
                targetAmount: main.target,
                memo: "",
                createdAt: Date(),
                updatedAt: Date()
            )
            for sId in main.subCategories.keys {
                PayNote.subCategories[sId] = SubCategoryEntity(
                    id: sId,
                    mainCategoryId: mId,
                    name: main.subCategories[sId]!,
                    memo: "", createdAt: Date(), updatedAt: Date()
                )
            }
            switch main.name {
            case "固定費", "収入":
                for i in 0...35 {
                    for sub in main.name == "固定費" ? sub1s : sub2s {
                        let cId = UUID()
                        PayNote.cashTransactions[cId] = CashTransactionEntity(
                            id: cId,
                            amount: sub.2,
                            subCategoryId: sub.0,
                            bankId: main.name == "固定費" ? bank1.0 : bank3.0,
                            date: Date().added(month: -i),
                            memo: "", createdAt: Date(), updatedAt: Date()
                        )
                        if i % 12 == 11 {
                        }
                    }
                }

            default:
                for _ in 0...(main.name == "生活費" ? 1500 : 240) {
                    let cId = UUID()
                    PayNote.cashTransactions[cId] = CashTransactionEntity(
                        id: cId,
                        amount: Int.random(in: 100...Int.random(in: 200...Int.random(in: 300...(main.name == "生活費" ? 6000 : 10000)))),
                        subCategoryId: main.subCategories.keys.randomElement()!,
                        bankId: main.banks.randomElement()!.0,
                        date: Date().added(day: -(Int.random(in: 0...1094))),
                        memo: main.memo.randomElement()!, createdAt: Date(), updatedAt: Date()
                    )
                }
            }
        }
    }
}
