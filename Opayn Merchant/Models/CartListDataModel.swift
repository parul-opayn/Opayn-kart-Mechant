//
//  CartListDataModel.swift
//  OpaynKart
//
//  Created by OPAYN on 26/08/21.
//

import Foundation


// MARK: - CarListDataModel

struct CarListDataModel: Codable {
    let message: String?
    let code: Int?
    var data: [Datum]?
    let settings: Settings?
}

// MARK: - Datum
struct Datum: Codable {
    let id, name, regularPrice, salePrice: String?
    var discount, quantity: String?
    let images: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
        case discount, quantity, images
    }
}

// MARK: - Settings
struct Settings: Codable {
    let id, tax, deliveryFee: String?
    let updatedAt: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, tax
        case deliveryFee = "delivery_fee"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
