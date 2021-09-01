//
//  ContactUsViewModel.swift
//  OpaynKart
//
//  Created by OPAYN on 25/08/21.
//

import Foundation


class ContactUsViewModel: BaseAPI {

    func contactUs(title:String,description:String,id:String,completion:@escaping(Bool,String)->()){
        
        let param = ["title":title,"description":description,"id":id] as baseParameters
        
        let request = Request(url: (URLS.baseUrl, APISuffix.enquiry), method: .post, parameters: param, headers: true)
        
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
                    
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
    }
    
}
