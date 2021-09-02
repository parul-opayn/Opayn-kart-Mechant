//
//  Singleton.swift
//  OpaynKart
//
//  Created by OPAYN on 30/08/21.
//

import Foundation

class Singleton {
    
    static let sharedInstance = Singleton()
    
    func UTCToLocal(date:String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: dt!)
    }
    
    
}
