//
//  ProductDetailsDataModel.swift
//  OpaynKart
//
//  Created by OPAYN on 25/08/21.
//

import Foundation

// MARK: - ProductDetailsModelElement

struct ProductDetailsDataModel: Codable {
    let id, name, regularPrice, salePrice: String?
    let discount, productDetailsModelDescription: String?
    var wishlist_status:Bool?
    let images: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
        case discount
        case productDetailsModelDescription = "description"
        case images
        case wishlist_status = "wishlist"
    }
}
