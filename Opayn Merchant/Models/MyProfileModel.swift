//
//  MyProfileModel.swift
//  OpaynKart
//
//  Created by OPAYN on 24/08/21.
//

import Foundation

// MARK: - Profile
struct Profile: Codable {
    let id, name, email, password: String?
    let mobile, image, updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, password, mobile, image
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
