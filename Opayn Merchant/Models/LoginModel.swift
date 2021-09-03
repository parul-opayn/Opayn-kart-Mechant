//
//  LoginModel.swift
//  Opayn Merchant
//
//  Created by OPAYN on 03/09/21.
//

import Foundation

// MARK: - LoginModel

struct LoginModel: Codable {
    let id, name, email, password: String?
    let mobile, image, updatedAt: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, password, mobile, image
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
