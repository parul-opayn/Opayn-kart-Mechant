//
//  MyProfileViewModel.swift
//  OpaynKart
//
//  Created by OPAYN on 24/08/21.
//

import Foundation

class MyProfileViewModel: BaseAPI {
    
    //MARK:- Variables
    
    var profileData:Profile?
    
    //MARK:- API Calls
    
    func myProfileAPI(completion:@escaping(Bool,String)->()){
        
        let param = ["id":(UserDefault.sharedInstance?.getUserDetails()?.id ?? "")!] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.profile), method: .get, parameters: param, headers: true)
        super.hitApi(requests: request) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        if let profileData = data["data"] as? [String:Any]{
                            do{
                                let json = try JSONSerialization.data(withJSONObject: profileData, options: .prettyPrinted)
                                self.profileData = try JSONDecoder().decode(Profile.self, from: json)
                                
                                //Update Data in UserDefaults to get smooth experience
                                
                                try UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject:profileData, requiringSecureCoding:true), forKey: "userData")
                                UserDefault.sharedInstance?.updateUserData()
                                
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
