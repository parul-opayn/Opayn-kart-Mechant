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
    var productsModel = ProductsDataModel()
    
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
    
    func filters(minPrice:String,maxPrice:String,categoryId:String,subCategoryId:String,search:String,completion:@escaping(Bool,String)->()){
        
        var param = baseParameters()
        
        if minPrice != ""{
            
            if minPrice == "0"{
                param["min_price"] = "00" as AnyObject
            }
            else{
                param["min_price"] = minPrice as AnyObject
            }
          
        }
        
        if maxPrice != ""{
            param["max_price"] = maxPrice as AnyObject
        }
        
        if categoryId != ""{
            param["category_id"] = categoryId as AnyObject
        }
        
        if subCategoryId != ""{
            param["sub_category_id"] = subCategoryId as AnyObject
        }
        
        if search != ""{
            param["search"] = search as AnyObject
        }
        
        let request = Request(url: (URLS.baseUrl, APISuffix.filters), method: .get, parameters: param, headers: true)
        super.hitApi(requests: request) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        if let homeData = data["data"] as? [[String:Any]]{
                            do{
                                let json = try JSONSerialization.data(withJSONObject: homeData, options: .prettyPrinted)
                                self.productsModel = try JSONDecoder().decode(ProductsDataModel.self, from: json)
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
    
}
