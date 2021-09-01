//
//  SetButton.swift
//  Wouk
//
//  Created by Amalendu Kar on 11/8/19.
//  Copyright © 2019 Promatics Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable
class SetButton: UIButton {
    
    //@IBInspectable
    open var borderColor: UIColor = UIColor.lightGray {
        didSet {
            self.updateBorder()
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            self.updateBorder()
        }
    }
    
    @IBInspectable open var isCircle: Bool = false {
        didSet {
            self.updateCornerRadious()
        }
    }
    
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            self.updateCornerRadious()
        }
    }
    
    @IBInspectable open var defaultCornerRadius: Bool = false {
        didSet {
            self.updateCornerRadious()
        }
    }
    
    @IBInspectable open var shadowEnabled: Bool = false {
        didSet {
            self.setShadow()
        }
    }
    
    @IBInspectable open var shadowColor: UIColor = UIColor.lightGray {
        didSet {
            self.setShadow()
        }
    }
    
    @IBInspectable open var shadowRadius: CGFloat = 0 {
        didSet {
            self.setShadow()
        }
    }
    
    @IBInspectable open var shadowOpacity: Float = 0 {
        didSet {
            self.setShadow()
        }
    }
    
    @IBInspectable open var shadowOffsetX: CGFloat = 0 {
        didSet {
            self.setShadow()
        }
    }
    
    @IBInspectable open var shadowOffsetY: CGFloat = 0 {
        didSet {
            self.setShadow()
        }
    }

    @IBInspectable open var paddingLeft: CGFloat = 0 {
        didSet {
            self.setPadding()
        }
    }
    
    @IBInspectable open var paddingRight: CGFloat = 0 {
        didSet {
            self.setPadding()
        }
    }
    
    @IBInspectable open var paddingTop: CGFloat = 0 {
        didSet {
            self.setPadding()
        }
    }
    
    @IBInspectable open var paddingBottom: CGFloat = 0 {
        didSet {
            self.setPadding()
        }
    }
    
//    @IBInspectable open var setGardient: Bool = false {
//        didSet {
//            self.updateGardient()
//        }
//    }
    
    @IBInspectable open var bounceButton: Bool = false
    
}

// MARK:- Functions

extension SetButton {
    
    private func setPadding(){
        self.titleEdgeInsets = UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: paddingBottom, right: paddingRight)
    }
    
    private func updateBorder(){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
    }
    
    private func updateCornerRadious(){
        
        if isCircle {
            
            self.layer.cornerRadius = self.frame.size.width/2
            
        }else if self.defaultCornerRadius {
            
            self.layer.cornerRadius = self.frame.size.height/2
            
        }else {
            
            self.layer.cornerRadius = cornerRadius
            
        }
        
        super.layer.cornerRadius = self.layer.cornerRadius
        
    }
    
//    private func updateGardient() {
//
//        self.setGradientColor(with: [UIColor.appLightGreen, UIColor.appLightBlue])
//
//    }
    
    private func setShadow(){
        
        if shadowEnabled {
            
            self.layer.masksToBounds = false
            
            self.layer.shadowColor = shadowColor.cgColor
            
            self.layer.shadowOpacity = shadowOpacity
            
            self.layer.shadowOffset = CGSize(width: shadowOffsetX, height: shadowOffsetY)
            
            self.layer.shadowRadius = shadowRadius
            
        }
        
    }
    
}

// MARK:- Spring Animation

extension SetButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (self.bounceButton){
            
            self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
                
                self.transform = CGAffineTransform.identity
                
            }, completion: nil)
            
        }
        
        super.touchesBegan(touches, with: event)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isUserInteractionEnabled = true
        super.touchesEnded(touches, with: event)
    }
    
}
