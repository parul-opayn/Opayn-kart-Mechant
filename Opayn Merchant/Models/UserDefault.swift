//
//  UserDefault.swift
//  OpaynKart
//
//  Created by OPAYN on 23/08/21.
//

import Foundation
import UIKit

class UserDefault
{
    var userData: LoginModel?
    static let sharedInstance : UserDefault? = UserDefault()
    
    private init()
    {
        if((UserDefaults.standard.value(forKey: "userData")) != nil)
        {
            let userdataa = NSKeyedUnarchiver.unarchiveObject(with: (UserDefaults.standard.value(forKey: "userData")) as! Data) as! [String: AnyObject]
            print("Unarhieved Data = ",userdataa)
            
            do {
                self.userData = try JSONDecoder().decode(LoginModel.self, from: JSONSerialization.data(withJSONObject: userdataa, options: .prettyPrinted))
                
            }
            catch {
               print((error.localizedDescription))
                
            }
            
        }
        else{
            self.userData = nil
            
        }
        
    }
    
    func updateUserData() {
        if((UserDefaults.standard.value(forKey: "userData")) != nil){
            
            let userdataa = NSKeyedUnarchiver.unarchiveObject(with: (UserDefaults.standard.value(forKey: "userData")) as! Data) as! [String: AnyObject]
            print(userdataa)
            
            do {
                self.userData = try JSONDecoder().decode(LoginModel.self, from: JSONSerialization.data(withJSONObject: userdataa, options: .prettyPrinted))
                
            }
            catch {
                
                print((error.localizedDescription))
                
            }
            
        } else{
            self.userData = nil
            
        }
        
    }
    
    func removeUserData() {
        UserDefaults.standard.removeObject(forKey: "userData")
        UserDefaults.standard.removeObject(forKey: "userData")
        UserDefault.sharedInstance?.updateUserData()
    }
    
    //MARK:- Getting User Data
    
    func getUserDetails() -> LoginModel? {
        return self.userData
    }
}
