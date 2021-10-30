//
//  SubCategoryEntity.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/07/31.
//

import Foundation

struct SubCategoryEntity {
    let id: UUID
    let mainCategoryId: UUID
    let name: String
    let memo: String
    let createdAt: Date
    let updatedAt: Date
}
