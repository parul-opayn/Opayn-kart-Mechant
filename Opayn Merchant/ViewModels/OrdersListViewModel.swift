//
//  OrdersListViewModel.swift
//  Opayn Merchant
//
//  Created by OPAYN on 02/09/21.
//

import Foundation

class OrdersListViewModel: BaseAPI {
    
    //MARK:- Variables
    
    var ordersListModel = OrdersList()
    
    //MARK:- API Calls
    func ordersListAPI(completion:@escaping(Bool,String)->()){
        
        let request = Request(url: (URLS.baseUrl, APISuffix.ordersList), method: .get, parameters: nil, headers: true)
        super.hitApi(requests: request) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        if let homeData = data["data"] as? [[String:Any]]{
                            do{
                                let json = try JSONSerialization.data(withJSONObject: homeData, options: .prettyPrinted)
                                self.ordersListModel = try JSONDecoder().decode(OrdersList.self, from: json)
                                completion(true,message ?? "")
                            }
                            catch{
                                print(error)
                                completion(false,message ?? "")
                            }
                        }
                        else{
                            completion(false,message ?? "")
                        }
                    }
                    else{
                        completion(false,message ?? "")
                    }
                }
                else{
                    
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
    }
    
    
    func changeOrderStatus(merchantOrderId:String,productId:String,status:String,completion:@escaping(Bool,String)->()){
        
        let param = ["order_id":merchantOrderId,"id":productId,"status":status] as baseParameters
        
        let request = Request(url: (URLS.baseUrl, APISuffix.changeOrderStatus), method: .post, parameters: param, headers: true)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    if data["code"] as? Int ?? -91 == 200{
                        completion(true,message ?? "")
                    }
                    else{
                        completion(false,message ?? "")
                    }
                }
                else{
                    
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
    }
    
}
