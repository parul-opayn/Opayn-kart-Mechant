//
//  SnackbarStyle.swift
//  OpaynKart
//
//  Created by OPAYN on 23/08/21.
//

import Foundation
import SnackBar_swift

class AppSnackBar: SnackBar {
    
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .black
        style.textColor = .white
//        style.actionTextColor = .white
        return style
    }
}

 

