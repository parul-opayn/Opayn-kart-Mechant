//
//  ForgotPasswordViewController.swift
//  Opayn Merchant
//
//  Created by OPAYN on 31/08/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var emailTxtd: UITextField!
    
    //MARK:- Variables
    
   var viewModel = ForgotPasswordViewModel()
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationWithBack(navtTitle: "Forgot Password",icon: #imageLiteral(resourceName: "back"),buttonType: .back)
    }
    
    //MARK:- Custom Methods
    
    //MARK:- Objc Methods
    
    //MARK:- IBActions
    
    @IBAction func tappedSendLink(_ sender: UIButton) {
        if emailTxtd.text?.replacingOccurrences(of: " ", with: "") == ""{
            self.showToast(message: "Please enter your email address.")
        }
        else if !Validation().validateEmailId(emailID: self.emailTxtd.text ?? ""){
            self.showToast(message: "Please enter valid email address.")
        }
        else{
            forgotPassword()
        }
    }
    

}


//MARK:- API Calls

extension ForgotPasswordViewController{
    
    func forgotPassword(){
        Indicator.shared.showProgressView(self.view)
        viewModel.forgotPasswordAPI(email: self.emailTxtd.text ?? "") {[weak self] isSuccess, message in
            Indicator.shared.hideProgressView()
            guard let self = self else{return}
            if isSuccess{
                let vc = self.storyboard?.instantiateViewController(identifier: "ResetPasswordViewController") as! ResetPasswordViewController
                vc.email = self.emailTxtd.text ?? ""
                vc.displayDataFor = .forgotPassword
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}
