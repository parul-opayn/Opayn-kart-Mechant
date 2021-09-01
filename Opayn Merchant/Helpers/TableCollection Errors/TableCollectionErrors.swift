//
//  TableCollectionErrors.swift
//  OpaynKart
//
//  Created by OPAYN on 26/08/21.
//

import Foundation
import UIKit

public func tableCollectionErrors<T>(view:T,text:String){
    if let table = view as? UITableView{
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: table.frame.width, height: table.frame.height)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        table.backgroundView = label
    }
    else if let collection = view as? UICollectionView{
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: collection.frame.width, height: collection.frame.height)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        collection.backgroundView = label
    }
    else{
        print("sdsds")
    }
    
}


public func displayRedErrorMessages<T>(view:T,text:String){
    if let table = view as? UITableView{
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: table.frame.width, height: table.frame.height)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        table.backgroundView = label
    }
    else if let collection = view as? UICollectionView{
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: collection.frame.width, height: collection.frame.height)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        collection.backgroundView = label
    }
    else{
        print("sdsds")
    }
    
}
