//
//  AppDelegate.swift
//  Opayn Merchant
//
//  Created by OPAYN on 30/08/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
    
        if UIDevice.current.userInterfaceIdiom == .pad{
            
            /**
            
            * #--Please Note --# *
             
             UILabels, UITextField and UITextViews have been adjusted with the below codes. If change require to update the font then please also look at extensions. UIButtons,UIImages and UIViews are getting changed from extensions.
             */
            
            let currentFont = UILabel().font
            UILabel.appearance().font = currentFont?.withSize((currentFont?.pointSize ?? 17) + 10)
        
            let textFieldFont = UITextField().font
            UITextField.appearance().font = textFieldFont?.withSize((textFieldFont?.pointSize ?? 17) + 10)
            
            let textViewFont = UITextView().font
            UITextView.appearance().font = textViewFont?.withSize((textViewFont?.pointSize ?? 17) + 10)
            UITextView.appearance().font = UIFont(name: textViewFont?.fontName ?? "Poppins-Regular", size: (textViewFont?.pointSize ?? 17) + 10)
            
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

