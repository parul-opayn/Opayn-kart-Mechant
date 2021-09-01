//
//  WishlistDataModel.swift
//  OpaynKart
//
//  Created by OPAYN on 26/08/21.
//

import Foundation

// MARK: - WishlistModelElement
struct WishlistModelElement: Codable {
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

typealias WishlistModel = [WishlistModelElement]

