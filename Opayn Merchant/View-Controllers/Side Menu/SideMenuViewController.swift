//
//  SideMenuViewController.swift
//  Opayn Merchant
//
//  Created by OPAYN on 31/08/21.
//

import UIKit
import SDWebImage

class SideMenuViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImageView: SetImage!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userImageHeight: NSLayoutConstraint!
    @IBOutlet weak var userImageWidth: NSLayoutConstraint!
    @IBOutlet weak var logoutBtn: UIButton!
    
    //MARK:- Variables
    
    var data = ["Add Products","Orders List","Products List","About us","Privacy Policy","Terms and Conditions","FAQ"]
    var imagesArray = [UIImage(named: "product"),UIImage(named: "order-list"),UIImage(named: "product-list"),UIImage(named: "AboutUs"),UIImage(named: "privacy"),UIImage(named: "terms-1"),UIImage(named: "FAQ")]
    var viewController = UIViewController()
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.navigationController?.isNavigationBarHidden = true
        changeFontSizes()
        displayUserData()
    }
    
    //MARK:- Custom Methods
    
    //MARK:- Objc Methods
    
    func changeFontSizes(){
        userNameLbl.changeFontSize()
        userEmailLbl.changeFontSize()
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.userImageHeight.constant = 120
            self.userImageWidth.constant = 120
        }
        logoutBtn.changeButtonLayout()
        logoutBtn.changeFontSize()
    }
    
    func displayUserData(){
        self.userImageView.sd_setImage(with: URL(string: URLS.baseUrl.getDescription() + (UserDefault.sharedInstance?.getUserDetails()?.image ?? "")), placeholderImage: #imageLiteral(resourceName: "profilePlaceholder"), options: .highPriority, context: nil)
        self.userNameLbl.text = UserDefault.sharedInstance?.getUserDetails()?.name ?? "Guest User"
        //self.userEmailLbl.text = UserDefault.sharedInstance?.getUserDetails()?.email ?? "N/A"
    }
    
    //MARK:- IBActions
    
    @IBAction func tappedBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func LogoutBtnTapped(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "userData")
        UserDefault.sharedInstance?.removeUserData()
        UserDefault.sharedInstance?.updateUserData()
        let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK:- TableView Delegates

extension SideMenuViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell") as! AddressTableViewCell
        cell.menuItemLabel.text = data[indexPath.row]
        cell.menuImage.image = imagesArray[indexPath.row]
        cell.menuItemLabel.changeFontSize()
        // cell.menuImage.changeLayout()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        
        case 0:
            self.dismiss(animated: true) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            }
          
            break
            
        case 1:
            
            self.dismiss(animated: true, completion: {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrdersListViewController") as! OrdersListViewController
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            })
            
            break
            
        case 2:
            self.dismiss(animated: true) {
                self.dismiss(animated: true, completion: nil)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductsListViewController") as! ProductsListViewController
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            }
            break
            
        case 3:
            
            self.dismiss(animated: true, completion: {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
                vc.generalDatatype = .aboutUs
                vc.hidesBottomBarWhenPushed = true
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            })
            
            break
            
        case 4:
            
            self.dismiss(animated: true, completion: {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
                vc.generalDatatype = .privacyPolicy
                vc.hidesBottomBarWhenPushed = true
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            })
            
            break
        case 5:
            
            self.dismiss(animated: true, completion: {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
                vc.generalDatatype = .terms
                vc.hidesBottomBarWhenPushed = true
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            })
            
        case 6:
            
            self.dismiss(animated: true, completion: {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
                vc.hidesBottomBarWhenPushed = true
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            })
            break
            
        default:
            break
        }
    }
    
}
