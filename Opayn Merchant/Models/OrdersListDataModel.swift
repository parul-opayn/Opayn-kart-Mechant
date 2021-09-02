//
//  OrdersListDataModel.swift
//  Opayn Merchant
//
//  Created by OPAYN on 02/09/21.
//

import Foundation

// MARK: - OrdersListElement

struct OrdersListElement: Codable {
    let id, fullName, email, phoneNumber: String?
    let address: String?
    var products: [Products]?
    let created_at:String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email
        case phoneNumber = "phone_number"
        case address, products
        case created_at
    }
}

// MARK: - Product
struct Products: Codable {
    let id, name, price, quantity: String?
    let images: [String]?
    var status:String?
}

typealias OrdersList = [OrdersListElement]
