//
//  ResetPasswordViewController.swift
//  Opayn Merchant
//
//  Created by OPAYN on 31/08/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var verificationCodeTxtFld: UITextField!
    @IBOutlet weak var passwordTxFld: UITextField!
    @IBOutlet weak var verificationCodeLbl: UILabel!
    @IBOutlet weak var resetPasswordCodeLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    //MARK:- Variables
    
   var viewModel = ForgotPasswordViewModel()
    var email = ""
    var displayDataFor:changePasswordFor = .forgotPassword
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDisplayData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.displayDataFor == .forgotPassword{
        self.navigationWithBack(navtTitle: "Reset Password",icon: #imageLiteral(resourceName: "back"),buttonType: .back)
        }
        else{
            self.navigationWithBack(navtTitle: "Change Password",icon: #imageLiteral(resourceName: "back"),buttonType: .back)
        }
    }
    
    //MARK:- Custom Methods
    
    func changeDisplayData(){
        if self.displayDataFor == .changePassword{
            emailLbl.text = "Current Password"
            self.verificationCodeLbl.text = "New Password"
            self.resetPasswordCodeLbl.text = "Confirm Password"
            emailTxtFld.isSecureTextEntry = true
            verificationCodeTxtFld.isSecureTextEntry = true
        }
        else{
            emailTxtFld.text = email
        }
    }
    
    //MARK:- Objc Methods
    
    //MARK:- IBActions
        
    @IBAction func tappedUpdatePassword(_ sender: UIButton) {
        
        if self.displayDataFor == .forgotPassword{
            if verificationCodeTxtFld.text?.replacingOccurrences(of: " ", with: "") == ""{
                self.showToast(message: "Please enter your verification code.")
            }
            else if passwordTxFld.text?.replacingOccurrences(of: " ", with: "") == ""{
                self.showToast(message: "Please enter your new password")
            }
            else{
                    resetPassword()
            }
        }
        
        else{
            if emailTxtFld.text?.replacingOccurrences(of: " ", with: "") == ""{
                self.showToast(message: "Please enter your current password.")
            }
            else if verificationCodeTxtFld.text?.replacingOccurrences(of: " ", with: "") == ""{
                self.showToast(message: "Please enter your new password")
            }
            else if passwordTxFld.text?.replacingOccurrences(of: " ", with: "") == ""{
                self.showToast(message: "Please confirm your new password")
            }
            else if verificationCodeTxtFld.text != passwordTxFld.text{
                self.showToast(message: "New password and Confirm did not match.")
            }
            else{
                changePassword()
            }
        }
    }
    
}


//MARK:- API Calls

extension ResetPasswordViewController{
    
    func resetPassword(){
        Indicator.shared.showProgressView(self.view)
        viewModel.resetPasswordAPI(validationCode: self.verificationCodeTxtFld.text ?? "",password: self.passwordTxFld.text ?? "") {[weak self] isSuccess, message in
            Indicator.shared.hideProgressView()
            guard let self = self else{return}
            if isSuccess{
                let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
    
    func changePassword(){
        Indicator.shared.showProgressView(self.view)
        viewModel.changePassword(oldPassword: emailTxtFld.text ?? "", newPassword: passwordTxFld.text ?? "", id: UserDefault.sharedInstance?.getUserDetails()?.id ?? "") {[weak self] isSuccess, message in
            Indicator.shared.hideProgressView()
            guard let self = self else{return}
            if isSuccess{
                UserDefaults.standard.removeObject(forKey: "userData")
                UserDefault.sharedInstance?.updateUserData()
                let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}
