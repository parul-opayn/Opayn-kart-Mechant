//
//  AddressListModel.swift
//  OpaynKart
//
//  Created by OPAYN on 27/08/21.
//

import Foundation


// MARK: - AddressListModelElement
struct AddressListModelElement: Codable {
    let id, userID, type, fullName: String?
    let phoneNumber, pincode, state, houseNo: String?
    let area, lat, lng: String?
    let updatedAt: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case type
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case pincode, state
        case houseNo = "house_no"
        case area, lat, lng
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

typealias AddressListModel = [AddressListModelElement]
