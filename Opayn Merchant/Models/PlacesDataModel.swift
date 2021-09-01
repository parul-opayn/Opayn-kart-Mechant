//
//  PlacesDataModel.swift
//  OpaynKart
//
//  Created by OPAYN on 27/08/21.
//

import Foundation

// MARK: - PlacesDataModelElement
struct PlacesDataModelElement: Codable {
    let placesDataModelDescription: String?
    let matchedSubstrings: [MatchedSubstring]?
    let placeID, reference: String?
    let structuredFormatting: StructuredFormatting?
    let terms: [Term]?
    let types: [String]?

    enum CodingKeys: String, CodingKey {
        case placesDataModelDescription = "description"
        case matchedSubstrings = "matched_substrings"
        case placeID = "place_id"
        case reference
        case structuredFormatting = "structured_formatting"
        case terms, types
    }
}

// MARK: - MatchedSubstring
struct MatchedSubstring: Codable {
    let length, offset: Int?
}

// MARK: - StructuredFormatting
struct StructuredFormatting: Codable {
    let mainText: String?
    let mainTextMatchedSubstrings: [MatchedSubstring]?
    let secondaryText: String?

    enum CodingKeys: String, CodingKey {
        case mainText = "main_text"
        case mainTextMatchedSubstrings = "main_text_matched_substrings"
        case secondaryText = "secondary_text"
    }
}

// MARK: - Term
struct Term: Codable {
    let offset: Int?
    let value: String?
}

typealias PlacesDataModel = [PlacesDataModelElement]



//MARK:- Places Coordinates


// MARK: - PlacesCoordinatesModel

struct PlacesCoordinatesModel: Codable {
    let addressComponents: [AddressComponent]?
    let adrAddress, formattedAddress: String?
    let geometry: Geometry?
    let icon: String?
    let iconBackgroundColor: String?
    let iconMaskBaseURI: String?
    let name: String?
    let photos: [Photo]?
    let placeID, reference: String?
    let types: [String]?
    let url: String?
    let utcOffset: Int?
    let vicinity: String?

    enum CodingKeys: String, CodingKey {
        case addressComponents = "address_components"
        case adrAddress = "adr_address"
        case formattedAddress = "formatted_address"
        case geometry, icon
        case iconBackgroundColor = "icon_background_color"
        case iconMaskBaseURI = "icon_mask_base_uri"
        case name, photos
        case placeID = "place_id"
        case reference, types, url
        case utcOffset = "utc_offset"
        case vicinity
    }
}

// MARK: - AddressComponent
struct AddressComponent: Codable {
    let longName, shortName: String?
    let types: [String]?

    enum CodingKeys: String, CodingKey {
        case longName = "long_name"
        case shortName = "short_name"
        case types
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let location: Location?
    let viewport: Viewport?
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double?
}

// MARK: - Viewport
struct Viewport: Codable {
    let northeast, southwest: Location?
}

// MARK: - Photo
struct Photo: Codable {
    let height: Int?
    let htmlAttributions: [String]?
    let photoReference: String?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case height
        case htmlAttributions = "html_attributions"
        case photoReference = "photo_reference"
        case width
    }
}

