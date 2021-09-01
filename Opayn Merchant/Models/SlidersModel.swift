//
//  SlidersModel.swift
//  OpaynKart
//
//  Created by OPAYN on 23/08/21.
//

import Foundation

// MARK: - Home
struct Home: Codable {
    let banner: [Banner]?
    let categories: [Category]?
    //let products: [Product]?
}

// MARK: - Banner
struct Banner: Codable {
    let id: String?
    let image: String?
    let updatedAt: CreatedAt?
    let createdAt: CreatedAt?

    enum CodingKeys: String, CodingKey {
        case id, image
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

// MARK: - CreatedAt
struct CreatedAt: Codable {
    let date: String?
    let timezoneType: Int?
    let timezone: String?

    enum CodingKeys: String, CodingKey {
        case date
        case timezoneType = "timezone_type"
        case timezone
    }
}

// MARK: - Product
struct Product: Codable {
    let id, name, regularPrice, salePrice: String?
    let discount: String?
    let images: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
        case discount, images
    }
}
