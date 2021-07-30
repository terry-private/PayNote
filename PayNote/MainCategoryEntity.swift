//
//  MainCategoryEntity.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/31.
//

import Foundation

struct MainCategoryEntity {
    let id: UUID
    let name: String
    let inOut: InOut
    let targetAmount: Int
    let memo: String
}
