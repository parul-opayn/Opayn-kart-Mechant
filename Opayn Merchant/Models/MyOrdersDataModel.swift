//
//  MyOrdersDataModel.swift
//  OpaynKart
//
//  Created by OPAYN on 30/08/21.
//

import Foundation

// MARK: - MyOrderDataModelElement

struct MyOrderDataModelElement: Codable {
    let orderID, total, tax, amount: String?
    let products: [ProductsData]?
    let created_at:String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case total, tax, amount, products
        case created_at
    }
}

// MARK: - Product
struct ProductsData: Codable {
    let id, name, quantity: String?
    let images: [String]?
    let price:String?
}

typealias MyOrderDataModel = [MyOrderDataModelElement]
