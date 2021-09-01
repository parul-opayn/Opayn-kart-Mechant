//
//  ApisSuffix.swift
//  GoFitNUp
//
//  Created by Sourabh Mittal on 16/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

enum APISuffix {
    
    case signUp
    case login
    case updateUser
    case profile
    case home
    case generalContent
    case faq
    case forgotPassword
    case resetPassword
    case changePassword
    case enquiry
    case productDetails(String)
    case searchText(String)
    case forCoordinates
    case userAddressList
    case myOrders
    case filters
    case addProduct
    case productList
    case deleteProduct(String)
    case editProduct
    case updateProduct
    case deleteImage
    
    func getDescription() -> String {
        
        switch self {
        
        case .signUp :
            return "user/create"
            
        case .login :
            return "user/login"
            
        case .updateUser:
            return "api/v1/user/update"
            
        case .profile:
            return "api/v1/user/profile?id"
            
        case .home:
            return "home"
            
        case .generalContent:
            return "general-content"
            
        case .faq:
            return "faqs"
            
        case .forgotPassword:
            return "forgot-password"
            
        case .resetPassword:
            return "password-reset"
            
        case .changePassword:
            return "api/v1/user/change-password"
            
        case .enquiry:
            return "api/v1/enquiry"
            
        case .productDetails(let id):
            if UserDefaults.standard.value(forKey: "token") != nil{
                return "api/v1/product-detail/\(id)"
            }
            else{
                return "product-detail/\(id)"
            }
            
        case .searchText(let text):
            return "AIzaSyA31rDpXXvW9AJyv31PNnBkNTNxnrM-nXo&input=\(text)"
            
        case .forCoordinates:
            return "&key=AIzaSyA31rDpXXvW9AJyv31PNnBkNTNxnrM-nXo"
            
        case .userAddressList:
            return "api/v1/user/address-list"
            
        case .myOrders:
            return "api/v1/orders"
            
        case .filters:
            return "filters"
            
        case .addProduct:
            return "api/v1/add-product"
            
        case .productList:
            return "api/v1/product-listing"
            
        case .deleteProduct(let productId):
            return "api/v1/product/\(productId)"
            
        case .editProduct:
            return "v1/update-product"
            
        case .updateProduct:
            return "api/v1/update-product"
            
        case .deleteImage:
            return "api/v1/delete-product-image"
        }
        
    }
}


enum URLS {
    case baseUrl
    case googlePlaces
    case reversePlaceId(String)
    
    
    func getDescription() -> String {
        
        switch self {
        
        case .baseUrl :
            return "http://6275-180-188-237-46.ngrok.io/"
            
        case .googlePlaces:
            return "https://maps.googleapis.com/maps/api/place/autocomplete/json?key="
            
        case .reversePlaceId(let placeId):
            return "https://maps.googleapis.com/maps/api/place/details/json?input=bar&placeid=\(placeId)"
        }
    }
}


//"
