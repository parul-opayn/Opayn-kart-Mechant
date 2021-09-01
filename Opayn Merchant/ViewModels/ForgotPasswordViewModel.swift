//
//  ForgotPasswordViewModel.swift
//  OpaynKart
//
//  Created by OPAYN on 25/08/21.
//

import Foundation

class ForgotPasswordViewModel: BaseAPI {
    
    func forgotPasswordAPI(email:String,completion:@escaping(Bool,String)->()){
        
        let param = ["email":email,"type":"merchant"] as baseParameters
        
        let request = Request(url: (URLS.baseUrl, APISuffix.forgotPassword), method: .post, parameters: param, headers: false)
        
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
    
    
    func resetPasswordAPI(validationCode:String,password:String,completion:@escaping(Bool,String)->()){
        
        let param = ["code":validationCode,"password":password,"type":"user"] as baseParameters
        
        let request = Request(url: (URLS.baseUrl, APISuffix.resetPassword), method: .post, parameters: param, headers: true)
        
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
    
    func changePassword(oldPassword:String,newPassword:String,id:String,completion:@escaping(Bool,String)->()){
        
        let param = ["old":oldPassword,"new":newPassword,"id":id] as baseParameters
        
        let request = Request(url: (URLS.baseUrl, APISuffix.changePassword), method: .post, parameters: param, headers: true)
        
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
