//
//  ProductsDataModel.swift
//  OpaynKart
//
//  Created by OPAYN on 25/08/21.
//

import Foundation

// MARK: - ProductsDataModelElement

struct ProductsDataModelElement: Codable {
    let id, name, regularPrice, salePrice: String?
    let discount: String?
    let images: [String]?
    var isWishlist:Bool?

    enum CodingKeys: String, CodingKey {
        case id, name
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
        case discount, images
    }
}

typealias ProductsDataModel = [ProductsDataModelElement]
