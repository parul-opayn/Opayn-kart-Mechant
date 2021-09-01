//
//  FAQViewModel.swift
//  OpaynKart
//
//  Created by OPAYN on 25/08/21.
//

import Foundation

class FAQViewModel: BaseAPI {
    
    //MARK:- Variables
    
    var faqModel = FAQDataModel()
    var temp = FAQDataModel()
    
    //MARK:- API Calls
    
    func FAQsAPI(completion:@escaping(Bool,String)->()){
        
        let request = Request(url: (URLS.baseUrl, APISuffix.faq), method: .get, parameters: nil, headers: false)
        super.hitApi(requests: request) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        if let generalData = data["data"] as? [[String:Any]]{
                            do{
                                let json = try JSONSerialization.data(withJSONObject: generalData, options: .prettyPrinted)
                                self.faqModel = try JSONDecoder().decode(FAQDataModel.self, from: json)
                                self.temp = self.faqModel
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
