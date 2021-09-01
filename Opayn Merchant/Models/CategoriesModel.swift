//
//  CategoriesModel.swift
//  OpaynKart
//
//  Created by OPAYN on 24/08/21.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    let id, parent, name: String?
    let image, updatedAt: String?
    let createdAt: String?
    let subCategories: [Category]?

    enum CodingKeys: String, CodingKey {
        case id, parent, name, image
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case subCategories
    }
}

typealias Categories = [Category]
