//
//  Extensions.swift
//  OpaynKart
//
//  Created by OPAYN on 16/08/21.
//

import Foundation
import UIKit
import SideMenu
import CoreLocation
import Photos

extension UIViewController{
    
    //MARK:- NavigationBar
    
    func navigationWithBack(navtTitle:String,icon:UIImage,buttonType:leftBarButtonType){
        let button = UIButton(type: .custom)
        button.setImage(icon, for: .normal)
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 27)!
            ]
            
            navigationController?.navigationBar.titleTextAttributes = attrs
            button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 60, height: 60))
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
          
        }
        else{
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 17)!
            ]
            
            navigationController?.navigationBar.titleTextAttributes = attrs
            button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30))
            button.imageView?.contentMode = .scaleAspectFill
        }
     
        button.changeButtonLayout()
        button.changeFontSize()
        if buttonType == .back{
            button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        }
        else if buttonType == .menu{
            button.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
        }
        else{
            button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.title = navtTitle
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        // self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       
        
    }
    
    func navigationWithTitleOnly(titleString:String){
        
        navigationItem.title = titleString
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        //   self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        if UIDevice.current.userInterfaceIdiom == .pad{
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 27)!
            ]
            
            navigationController?.navigationBar.titleTextAttributes = attrs
        }
        else{
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 17)!
            ]
            
            navigationController?.navigationBar.titleTextAttributes = attrs
        }
    }
    
    func navigationWithTwoRightButtons(){
        let menu = UIButton(type: .custom)
        menu.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        menu.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30))
        menu.layer.cornerRadius = 20
        menu.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menu)
        
        let filter = UIButton()
        filter.imageView?.contentMode =  .scaleAspectFit
        filter.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        filter.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        filter.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: filter)]
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        // self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        if UIDevice.current.userInterfaceIdiom == .pad{
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 27)!
            ]
            
            navigationController?.navigationBar.titleTextAttributes = attrs
        }
        else{
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 17)!
            ]
            
            navigationController?.navigationBar.titleTextAttributes = attrs
        }
    }
    
    func navigationWithCart(){
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30))
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        let cart = UIButton()
        cart.imageView?.contentMode =  .scaleAspectFit
        cart.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        cart.setImage(#imageLiteral(resourceName: "bag").withRenderingMode(.alwaysOriginal), for: .normal)
        cart.addTarget(self, action: #selector(didTapCart), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cart)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        //  self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        if UIDevice.current.userInterfaceIdiom == .pad{
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 27)!
            ]
            
            navigationController?.navigationBar.titleTextAttributes = attrs
        }
        else{
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 17)!
            ]
            
            navigationController?.navigationBar.titleTextAttributes = attrs
        }
    }
    
    func adjustLayout(){
        
        for view in self.view.subviews{
            if view is UILabel{
                ( view as! UILabel).changeFontSize()
            }
            else if view is UIButton{
                print("Button found")
                (view as! UIButton).changeFontSize()
                (view as! UIButton).changeButtonLayout()
            }
            else if view is UITextField{
                (view as! UITextField).changeFontSize()
            }
            else if view is UIView{
                view.subviews.forEach { subView in
                    if subView is UILabel{
                        ( subView as! UILabel).changeFontSize()
                    }
                    else if subView is UIButton{
                        print("Button found")
                        (subView as! UIButton).changeFontSize()
                        (subView as! UIButton).changeButtonLayout()
                    }
                    else if subView is UITextField{
                        (subView as! UITextField).changeFontSize()
                    }
                }
            }
        }
    }
    
    
    @objc func didTapMenu(){
        
        let vc = storyboard!.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = self.view.bounds.width
        menu.presentDuration = 0.25
        vc.viewController = self
        menu.navigationController?.isNavigationBarHidden = true
        self.present(menu, animated: true, completion: nil)
        
    }
    
    @objc func didTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapSearch(){
        //
        print("search")
    }
    
    @objc func didTapCart(){
        //
        print("CART")
    }
    
    @objc func didTapFilter(){
        //        // self.navigationController?.popViewController(animated: true)
        //        print("Filter")
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FiltersViewController") as! FiltersViewController
        //        vc.viewController = self
        //        if let parent = self as? ProductsCategoryViewController{
        //            vc.delegate = parent
        //        }
        //        vc.modalPresentationStyle = .overFullScreen
        //        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    //MARK:- CollectionView Height Manager
    
    func updateCollectionHeight(collectionName : UICollectionView , collectionHeight : NSLayoutConstraint){
        var frame = collectionName.frame
        frame.size.height = collectionName.contentSize.height
        collectionName.frame = frame
        collectionName.reloadData()
        //collectionName.layoutIfNeeded()
        collectionHeight.constant = CGFloat(collectionName.contentSize.height)
        collectionName.reloadData()
    }
    
    //MARK:- TableView Height Manager
    
    func updateTableHeight(tableName : UITableView , tableHeight : NSLayoutConstraint){
        var frame = tableName.frame
        frame.size.height = tableName.contentSize.height
        tableName.frame = frame
        tableName.reloadData()
        tableName.layoutIfNeeded()
        tableHeight.constant = CGFloat(tableName.contentSize.height)
    }
    
    func presentWithTransition(vc:UIViewController, from presentingController:UIViewController){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        vc.modalPresentationStyle = .overCurrentContext
        presentingController.present(vc, animated: false, completion: nil)
    }
    
    func dismissWithTransition(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
    func generateUniqueName(withSuffix suffix:String)->String{
        let uuid = UUID().uuidString
        return "OpaynKart-\(uuid)\(suffix)"
    }
}


extension UIButton{
    func changeButtonLayout(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            if let c = self.constraints.first(where: { $0.firstAttribute == .height && $0.relation == .equal }) {
                c.constant = CGFloat((self.frame.height) + 30)
                self.superview?.layoutIfNeeded()
            }
        }
    }
}


extension UIImageView{
    
    func changeLayout(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.heightConstraint?.constant += 100
            self.widthConstraint?.constant += 100
        }
    }
    
    
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
}


extension UIView{
    func changeViewLayout(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            if let c = self.constraints.first(where: { $0.firstAttribute == .height && $0.relation == .equal }) {
                c.constant = CGFloat((self.frame.height) + 20)
                self.superview?.layoutIfNeeded()
            }
        }
    }
    
}


//MARK:- Fonts Adjustment As Per Device


extension UIButton{
    func changeFontSize(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize ?? 17) + 10)
        }
        else{
            self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize ?? 17))
        }
    }
}

extension UITextField{
    func changeFontSize(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17) + 10)
        }
        else{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17))
        }
    }
}


extension UITextView{
    func changeFontSize(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17) + 10)
        }
        else{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17))
        }
    }
}

extension UILabel{
    func changeFontSize(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17) + 10)
        }
        else{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17))
        }
    }
}

extension UIStackView{
    func changeSpacin(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.spacing = 32
        }
    }
}


extension UITableViewCell{
    func adjustLayout(){
        for view in self.contentView.subviews{
            if view is UILabel{
                ( view as! UILabel).changeFontSize()
            }
            else if view is UIButton{
                print("Button found")
                (view as! UIButton).changeFontSize()
                (view as! UIButton).changeButtonLayout()
            }
            else if view is UITextField{
                (view as! UITextField).changeFontSize()
            }
            else if view is UIView{
                view.subviews.forEach { subView in
                    if subView is UILabel{
                        ( subView as! UILabel).changeFontSize()
                    }
                    else if subView is UIButton{
                        print("Button found")
                        (subView as! UIButton).changeFontSize()
                        (subView as! UIButton).changeButtonLayout()
                    }
                    else if subView is UITextField{
                        (subView as! UITextField).changeFontSize()
                    }
                }
            }
        }
    }
    
    
}


//MARK:- Reverse GeoCode

extension UIViewController{
    
    func getAddress(lat:Double,long:Double,completion:@escaping(ReverseGeoCode?)->()) {
        
        var address: ReverseGeoCode?
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = long
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                            completion(address)
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            print(pm.country as Any)
                                            address?.country = pm.country
                                            print(pm.locality as Any)
                                            address?.locatlity = pm.locality
                                            print(pm.subLocality as Any)
                                            address?.subLocality = pm.subLocality
                                            print(pm.thoroughfare as Any)
                                            print(pm.postalCode as Any)
                                            address?.zip = pm.postalCode
                                            print(pm.subThoroughfare as Any)
                                            address?.state = pm.administrativeArea
                                            //
                                            address = ReverseGeoCode(locationName: pm.name, street: pm.thoroughfare, city: pm.locality, state: pm.administrativeArea, zip: pm.postalCode, country: pm.country, locatlity: pm.locality, subLocality: pm.subLocality)
                                            //
                                            //
                                            completion(address)
                                        }
                                    })
        
    }
}


extension Notification.Name{
    static let expiredToken = Notification.Name(rawValue: "expiredToken")
}


extension UIViewController{
    
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
        var arrayOfImages = [UIImage]()
        for asset in assets {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var image = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                image = result!
                arrayOfImages.append(image)
            })
        }
        
        return arrayOfImages
    }
    
}
