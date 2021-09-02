//
//  ProductsListMode.swift
//  Opayn Merchant
//
//  Created by OPAYN on 01/09/21.
//

import Foundation

// MARK: - ProductsListElement

struct ProductsListElement: Codable {
    let id, name, regularPrice, salePrice: String?
    let discount: String?
    var images: [String]?
    let description:String?
    let cat_id: String?
    let sub_cat_id: String?
    let quantity:String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
        case discount, images,description,cat_id,sub_cat_id
        case quantity = "stock"
    }
}

typealias ProductsList = [ProductsListElement]
