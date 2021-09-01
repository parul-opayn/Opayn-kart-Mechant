//
//  Indicator.swift
//  OpaynKart
//
//  Created by OPAYN on 23/08/21.
//


import Foundation
import UIKit

open class Indicator {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    open class var shared: Indicator {
        struct Static {
            static let instance: Indicator = Indicator()
        }
        return Static.instance
    }
    
    open func showProgressView(_ view: UIView) {
        
        view.endEditing(true)
        containerView.frame = (UIApplication.shared.keyWindow?.frame)!
        containerView.frame.origin = CGPoint(x: 0, y: 0)
        
        //containerView.center = view.center
        containerView.backgroundColor = UIColor(hex: 0x000000, alpha: 0.4)
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = containerView.center//view.center
        //progressView.backgroundColor = UIColor(hex: 0xA80C5E, alpha: 0.7)
        progressView.backgroundColor = UIColor(red: 227/255, green: 244/255, blue: 235/255, alpha: 0.0)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.backgroundColor = UIColor.clear
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        // view.addSubview(containerView)
        UIApplication.shared.keyWindow?.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    open func hideProgressView() {
        
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
        
    }
}

extension UIColor {
    
    convenience init(hex: UInt32, alpha: CGFloat) {
        
        let red     = CGFloat((hex & 0xFF0000) >> 16)   / 256.0
        let green   = CGFloat((hex & 0xFF00) >> 8)      / 256.0
        let blue    = CGFloat(hex & 0xFF)               / 256.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
        
    }
}

