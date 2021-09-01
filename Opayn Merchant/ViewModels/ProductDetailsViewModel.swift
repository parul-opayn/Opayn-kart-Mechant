//
//  ProductDetailsViewModel.swift
//  OpaynKart
//
//  Created by OPAYN on 25/08/21.
//

import Foundation

class ProductDetailsViewModel: BaseAPI {
    
    var detailsModel:ProductDetailsDataModel?
    
    func productDetails(productId:String,completion:@escaping(Bool,String)->()){
        
        let request = Request(url: (URLS.baseUrl, APISuffix.productDetails(productId)), method: .get, parameters: nil, headers: true)
        super.hitApi(requests: request) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        if let details = data["data"] as? [String:Any]{
                            do{
                                let json = try JSONSerialization.data(withJSONObject: details, options: .prettyPrinted)
                                self.detailsModel = try JSONDecoder().decode(ProductDetailsDataModel.self, from: json)
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
