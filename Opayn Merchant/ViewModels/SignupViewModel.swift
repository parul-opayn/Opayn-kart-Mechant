//
//  SignupViewModel.swift
//  OpaynKart
//
//  Created by OPAYN on 23/08/21.
//

import Foundation

class SignupViewModel: BaseAPI {
    
    //MARK:- API Calls
    
    func signupAPI(name:String,email:String,password:String,completion:@escaping(Bool,String)->()){
        let param = ["name":name,"email":email,"password":password,"type":"merchant"] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.signUp), method: .post, parameters: param, headers: true)
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
    
    func validation(name:String,email:String,password:String,repeatPassword:String)->(Bool,String){
        if (name.replacingOccurrences(of: " ", with: "") == "")  && (email.replacingOccurrences(of: " ", with: "") == "") && (password.replacingOccurrences(of: " ", with: "") == "") && (repeatPassword.replacingOccurrences(of: " ", with: "") == ""){
            return(false,"Please enter all the required fields")
        }
        else if name.replacingOccurrences(of: " ", with: "") == ""{
            return(false,"Please enter your name.")
        }
        else if email.replacingOccurrences(of: " ", with: "") == ""{
            return(false,"Please enter your email address.")
        }
        else if password.replacingOccurrences(of: " ", with: "") == ""{
            return(false,"Please enter your password")
        }
        else if repeatPassword.replacingOccurrences(of: " ", with: "") == ""{
            return(false,"Please repeat your password")
        }
        else if !Validation().validateEmailId(emailID: email){
            return(false,"Please enter a valid email id")
            
        }
        else if password.count < 6{
            return(false,"Password must contain atleast 6 characters")
        }
        else if password != repeatPassword{
            return(false,"Password and confirm password did not match")
        }
        else{
            return(true,"success")
        }
    }
    
}
