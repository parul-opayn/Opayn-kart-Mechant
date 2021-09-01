//
//  GenralContentModel.swift
//  OpaynKart
//
//  Created by OPAYN on 25/08/21.
//

import Foundation

struct GeneralContentModel: Codable {
    let id, type, content: String?
    let updatedAt: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, type, content
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

struct ReverseGeoCode {
    var locationName:String?
    var street:String?
    var city:String?
    var state:String?
    var zip:String?
    var country:String?
    var locatlity:String?
    var subLocality:String?
}
