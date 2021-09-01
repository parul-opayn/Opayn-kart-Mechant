//
//  GeneralContentViewModel.swift
//  OpaynKart
//
//  Created by OPAYN on 25/08/21.
//

import Foundation

class GeneralContentViewModel: BaseAPI {
    
    //MARK:- Varaibles
    
    var model:GeneralContentModel?
    
    //MARK:- API Calls
    
    func generalContent(type:String,completion:@escaping(Bool,String)->()){
        
        let param = ["type":type] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.generalContent), method: .get, parameters: param, headers: false)
        super.hitApi(requests: request) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        if let generalData = data["data"] as? [String:Any]{
                            do{
                                let json = try JSONSerialization.data(withJSONObject: generalData, options: .prettyPrinted)
                                self.model = try JSONDecoder().decode(GeneralContentModel.self, from: json)
                                
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
