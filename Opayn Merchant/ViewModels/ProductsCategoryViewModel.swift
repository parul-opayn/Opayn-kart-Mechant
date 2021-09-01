//
//  ProductsCategoryViewModel.swift
//  OpaynKart
//
//  Created by OPAYN on 23/08/21.
//

import Foundation

class ProductsCategoryViewModel: BaseAPI {
    
    //MARK:- Variables
    
    var home : Home?
    var categoriesModel = Categories()
    var productsListModel = ProductsList()
    
    //MARK:-API Integrations
    
    func homeAPI(completion:@escaping(Bool,String)->()){
        
        let request = Request(url: (URLS.baseUrl, APISuffix.home), method: .get, parameters: nil, headers: true)
        super.hitApi(requests: request) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        if let homeData = data["data"] as? [String:Any]{
                            do{
                                let json = try JSONSerialization.data(withJSONObject: homeData, options: .prettyPrinted)
                                self.home = try JSONDecoder().decode(Home.self, from: json)
                                completion(true,message ?? "")
                            }
                            catch{
                                print(error)
                                completion(false,message ?? "")
                            }
                        }
                        else{
                            completion(false,message ?? "")
                        }
                    }
                    else{
                        completion(false,message ?? "")
                    }
                }
                else{
                    
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
    }
    
//    func filters(minPrice:String,maxPrice:String,categoryId:String,subCategoryId:String,search:String,completion:@escaping(Bool,String)->()){
//
//        var param = baseParameters()
//
//        if minPrice != ""{
//
//            if minPrice == "0"{
//                param["min_price"] = "00" as AnyObject
//            }
//            else{
//                param["min_price"] = minPrice as AnyObject
//            }
//
//        }
//
//        if maxPrice != ""{
//            param["max_price"] = maxPrice as AnyObject
//        }
//
//        if categoryId != ""{
//            param["category_id"] = categoryId as AnyObject
//        }
//
//        if subCategoryId != ""{
//            param["sub_category_id"] = subCategoryId as AnyObject
//        }
//
//        if search != ""{
//            param["search"] = search as AnyObject
//        }
//
//        let request = Request(url: (URLS.baseUrl, APISuffix.filters), method: .get, parameters: param, headers: true)
//        super.hitApi(requests: request) { receivedData, message, responseCode in
//            if responseCode == 1{
//                if let data = receivedData as? [String:Any]{
//                    if data["code"] as? Int ?? -91 == 200{
//                        if let homeData = data["data"] as? [[String:Any]]{
//                            do{
//                                let json = try JSONSerialization.data(withJSONObject: homeData, options: .prettyPrinted)
//                                self.productsModel = try JSONDecoder().decode(ProductsDataModel.self, from: json)
//                                completion(true,message ?? "")
//                            }
//                            catch{
//                                print(error)
//                                completion(false,message ?? "")
//                            }
//                        }
//                        else{
//                            completion(false,message ?? "")
//                        }
//
//                    }
//                    else{
//                        completion(false,message ?? "")
//                    }
//                }
//                else{
//
//                }
//            }
//            else{
//                completion(false,message ?? "")
//            }
//        }
//    }
    
    
    func addProduct(productId:String?,catId:String,subCatId:String,name:String,description:String,regularPrice:String,salePrice:String,fileName:[String],fileType:[String],fileParam:[String],fileData:[Data],completion:@escaping(Bool,String)->()){
        
        var param = ["cat_id":catId,"sub_cat_id":subCatId,"name":name,"description":description,"regular_price":regularPrice,"sale_price":salePrice] as baseParameters
        
        var request:RequestFilesData?
        
        if let pId = productId{
            param["id"] = pId as AnyObject
            request = RequestFilesData(url: (URLS.baseUrl, APISuffix.updateProduct), method: .post, parameters: param, headers: true, fileData: fileData, fileName: fileName, fileMimetype: fileType, fileParam: fileParam, numberOfFiles: fileData.count)
        }
        else{
            request = RequestFilesData(url: (URLS.baseUrl, APISuffix.addProduct), method: .post, parameters: param, headers: true, fileData: fileData, fileName: fileName, fileMimetype: fileType, fileParam: fileParam, numberOfFiles: fileData.count)
        }
       
        super.hitApiWithMultipleFile(requests: request!) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        completion(true,message ?? "")
                    }
                    else{
                        completion(false,message ?? "")
                    }
                }
                else{
                    completion(false,message ?? "")
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
    }
    
    func productsListAPI(completion:@escaping(Bool,String)->()){
        
        let request = Request(url: (URLS.baseUrl, APISuffix.productList), method: .get, parameters: nil, headers: true)
        super.hitApi(requests: request) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        if let homeData = data["data"] as? [[String:Any]]{
                            do{
                                let json = try JSONSerialization.data(withJSONObject: homeData, options: .prettyPrinted)
                                self.productsListModel = try JSONDecoder().decode(ProductsList.self, from: json)
                                completion(true,message ?? "")
                            }
                            catch{
                                print(error)
                                completion(false,message ?? "")
                            }
                        }
                        else{
                            completion(false,message ?? "")
                        }
                    }
                    else{
                        completion(false,message ?? "")
                    }
                }
                else{
                    
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
    }
    
    func deleteProductAPI(productId:String,completion:@escaping(Bool,String)->()){
        
        let request = Request(url: (URLS.baseUrl, APISuffix.deleteProduct(productId)), method: .delete, parameters: nil, headers: true)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        completion(true,message ?? "")
                    }
                    else{
                        completion(false,message ?? "")
                    }
                }
                else{
                    completion(false,message ?? "")
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
    }
    
    func deleteImagesAPI(productId:String,image:String,completion:@escaping(Bool,String)->()){
        
        let param = ["image":image,"product_id":productId] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.deleteImage), method: .post, parameters: param, headers: true)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        completion(true,message ?? "")
                    }
                    else{
                        completion(false,message ?? "")
                    }
                }
                else{
                    completion(false,message ?? "")
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
    }
    
    
    //MARK:- Validations
    
    func addProductValidation(title:String,des:String,salePrice:String,regularPrice:String,category:String)->(Bool,String){
        if (title.replacingOccurrences(of: " ", with: "") == "") && (des.replacingOccurrences(of: " ", with: "") == "") && (salePrice.replacingOccurrences(of: " ", with: "") == "") && (regularPrice.replacingOccurrences(of: " ", with: "") == "") && (category.replacingOccurrences(of: " ", with: "") == ""){
            return(false,"Please fill all the required details.")
        }
        else if (title.replacingOccurrences(of: " ", with: "") == ""){
            return(false,"Please enter title")
        }
        else if (des.replacingOccurrences(of: " ", with: "") == ""){
            return(false,"Please enter description")
        }
        else if (salePrice.replacingOccurrences(of: " ", with: "") == ""){
            return(false,"Please enter sale price")
        }
        else if (regularPrice.replacingOccurrences(of: " ", with: "") == ""){
            return(false,"Please enter regular price")
        }
        else if (category.replacingOccurrences(of: " ", with: "") == ""){
            return(false,"Please select category")
        }
        else if (Double(salePrice) ?? 0.0) > (Double(regularPrice) ?? 0.0){
            return(false,"Sale price can't be greater than regular price")
        }
        else{
            return(true,"success")
        }
    }
    
    
}
