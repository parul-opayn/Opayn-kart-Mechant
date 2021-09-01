//
//  LoginViewModel.swift
//  OpaynKart
//
//  Created by OPAYN on 23/08/21.
//

import Foundation

class LoginViewModel: BaseAPI {
    
    func validation(email:String,password:String)->(Bool,String){
        if (email.replacingOccurrences(of: " ", with: "") == "") && (password.replacingOccurrences(of: " ", with: "") == ""){
            return(false,"Please enter all the required fields")
        }
        
        else if email.replacingOccurrences(of: " ", with: "") == ""{
            return(false,"Please enter your email address.")
        }
        else if password.replacingOccurrences(of: " ", with: "") == ""{
            return(false,"Please enter your password")
        }
        else{
            return(true,"success")
        }
    }
    
    func loginAPI(email:String,password:String,completion:@escaping(Bool,String)->()){
        let param = ["email":email,"password":password,"type":"merchant"] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.login), method: .post, parameters: param, headers: true)
        super.hitApi(requests: request) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        if let userData = data["data"] as? [String:Any]{
                            do{
                                try UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject:userData, requiringSecureCoding:true), forKey: "userData")
                                UserDefault.sharedInstance?.updateUserData()
                                completion(true,message ?? "")
                            }
                            catch{
                                completion(false,message ?? "")
                            }
                            
                            if let token = data["token"] as? String{
                                UserDefaults.standard.setValue(token, forKey: "token")
                            }
                            else{
                                print("Please review the token is missing")
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
