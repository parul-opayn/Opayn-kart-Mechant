//
//  SignupViewController.swift
//  Opayn Merchant
//
//  Created by OPAYN on 31/08/21.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var registerHeadingLabel: UILabel!
    @IBOutlet weak var fillFormLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var fullNameTxtFld: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var createPasswordLbl: UILabel!
    @IBOutlet weak var createPasswordTxtFld: UITextField!
    @IBOutlet weak var reapeatPasswordLbl: UILabel!
    @IBOutlet weak var repeatTxtFld: UITextField!
    @IBOutlet weak var registerBtn: SetButton!
    @IBOutlet weak var alreadyHaveAccntLbl: UILabel!
    @IBOutlet weak var signnBtn: UIButton!
    @IBOutlet weak var fieldStackView: UIStackView!
    
    //MARK:- Variables
    
    var viewModel = SignupViewModel()
        
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        //self.navigationWithBack(navtTitle: "")
        changeFontAndSizes()
    }
    
    //MARK:- Custom Methods

    func changeFontAndSizes(){
        registerHeadingLabel.changeFontSize()
        fillFormLbl.changeFontSize()
        fullNameLbl.changeFontSize()
        fullNameTxtFld.changeFontSize()
        emailLbl.changeFontSize()
        emailTxtFld.changeFontSize()
        createPasswordLbl.changeFontSize()
        createPasswordTxtFld.changeFontSize()
        reapeatPasswordLbl.changeFontSize()
        repeatTxtFld.changeFontSize()
        registerBtn.changeButtonLayout()
        registerBtn.changeFontSize()
        alreadyHaveAccntLbl.changeFontSize()
        signnBtn.changeButtonLayout()
        signnBtn.changeFontSize()
        self.fieldStackView.changeSpacin()
    }
    
    //MARK:- Objc Methods
    
    //MARK:- IBActions
    
    @IBAction func tappedSigninBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedRegisterBtn(_ sender: UIButton) {
        let validation = viewModel.validation(name: fullNameTxtFld.text ?? "", email: emailTxtFld.text ?? "", password: createPasswordTxtFld.text ?? "", repeatPassword: repeatTxtFld.text ?? "")
        if validation.0{
            signupAPI()
        }
        else{
            self.showToast(message: validation.1)
        }
    }
}

//MARK:- API calls

extension SignUpViewController{
    func signupAPI(){
        Indicator.shared.showProgressView(self.view)
        viewModel.signupAPI(name: fullNameTxtFld.text ?? "", email: emailTxtFld.text ?? "", password: createPasswordTxtFld.text ?? "") { isSuccess, message in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.showAlertWithAction(Title: "OpaynKart", Message: "Signup Successful", ButtonTitle: "OK") {
                    self.showToast(message: "Signup Successful")
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                self.showToast(message: message)
            }
        }
    }
}
