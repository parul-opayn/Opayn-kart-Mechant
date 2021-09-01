//
//  Toast.swift
//  OpaynKart
//
//  Created by OPAYN on 23/08/21.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showToast(message:String){
        AppSnackBar.make(in: self.view, message: "  \(message)  ", duration: .custom(1.0)).show()
    }
    
    func showToastWithAction(message:String,ButtonTitle:String,completion:@escaping()->()){
        AppSnackBar.make(in: self.view, message: "The Internet connection appears to be offline.", duration: .lengthLong).setAction(with: "\(ButtonTitle)", action: {
            
            print("\(ButtonTitle) Tapped")
            completion()
            
        }).show()
    }
    
}

