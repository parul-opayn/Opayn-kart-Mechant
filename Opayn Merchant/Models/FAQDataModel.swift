//
//  FAQDataModel.swift
//  OpaynKart
//
//  Created by OPAYN on 25/08/21.
//

import Foundation


// MARK: - FAQDataModelElement

struct FAQDataModelElement: Codable {
    let id, question, answer: String?
    let updatedAt: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, question, answer
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

typealias FAQDataModel = [FAQDataModelElement]
