//
//  BaseAPI.swift
//  BaseAPI
//
//  Created by Serhii Londar on 12/8/17.
//

import Foundation
import Alamofire
//import SDWebImage

typealias BaseAPICompletion = (Any?, String? , Int) -> Swift.Void
typealias BaseAPIResult = SynchronousDataTaskResult
typealias baseParameters = [String : AnyObject]
typealias SynchronousDataTaskResult = (Any? , URLResponse? , Error?)
typealias FileData = (Data? , String? , Int) -> Void


class BaseAPI {

   var task: DataRequest?
    var request : URLRequest?
    var uploadRequest: UploadRequest?
    
    init() {
        print(#file , "initializer")
    }
    
    deinit {
        print(#file , "destructed")
    }
    
    /**
     The below function is used to download images from server and sets to user's profile image.
     */
    
    func downloadFile(fileUrls : URLS , completion : @escaping FileData) -> Void{
        
        let finalUrl = fileUrls.getDescription()
        guard let url = URL(string: finalUrl) else { print("Error in URl");
            print(finalUrl)
            //completion(nil , Messages.errorInURL, 0)
            return
        }
        
        print(url)
        
        AF.request(url).responseData { (response) in
            
            print(response)
            
            if response.response != nil {
                
                if let _data = response.data {
                    
                    switch response.response?.statusCode ?? -91 {
                        
                    case 0...100 :
                        print("* * * * * * * FAILED * * * * * * ")
                        completion(_data, response.description , 0)
                        
                    case 101...199 :
                        print("* * * * * * * FAILED * * * * * * ")
                        completion(_data, response.description, 0)
                        
                    case 200...299:
                        print("* * * * * * * SUCCESS * * * * * * ")
                        completion(_data, response.description ,1)
                        
                    case 300...399:
                        print("* * * * * * * FAILED * * * * * * ")
                        completion(_data, response.description ,2)
                        
                    default :
                        print("* * * * * * * FAILED * * * * * * ")
                        completion(_data,response.description, 2)
                    }
                    
                } else {
                    completion(nil,response.description, 2)
                }
            } else {
                completion(nil,response.description, 2)
            }
        }
    }
    
    
    /**
     
     This is for post type to upload any single file
     
     - getting data from internet
     - upload data to internet
     
     */
    
    func hitApiWithSingleFile(requests : RequestFileData , completion : @escaping BaseAPICompletion ) {
        
        var request = URLRequest(url: URL(string: requests.url)!)
        
        request.httpMethod = requests.method.rawValue
        
        let parameters = requests.parameters ?? [:]
        
        if requests.parameters != nil {
            do {
                request.httpBody = try? JSONSerialization.data(withJSONObject: requests.parameters ?? [:], options: .prettyPrinted)
            }
        }
        request.allHTTPHeaderFields = requests.headers ?? [:]
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
       // NetworkLogger.log(request: request)
        
        self.uploadRequest = AF.upload(multipartFormData: { multipart_FormData in
            
            multipart_FormData.append(requests.fileData, withName: requests.fileparam, fileName: requests.fileName, mimeType: requests.fileMimetype)
            
            for (key, value) in parameters {
                
                if let array = value as? [AnyObject] {
                    
                    for i in array {
                        multipart_FormData.append(String(describing: i).data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
                    /*   if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                     multipart_FormData.append(jsonData, withName: key as String)
                     _}
                     _            */
                    
                }else if let _ = value as? Parameters {
                    
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                        multipart_FormData.append(jsonData, withName: key as String)
                    }
                    
                } else {
                    multipart_FormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    
                }
                
            }
            
        }, with: request).responseJSON { [weak self] (response) in
            
           // NetworkLogger.log(response: response.response ?? URLResponse())
            
            self?.serializedResponse(withResponse: response, clouser: { (receivedData, message, response) in
                completion(receivedData,message,response)
                self?.uploadRequest = nil
            })
        }
        
        self.uploadRequest?.uploadProgress(closure: { (progress) in
            print()
            print("Uploading Data " , ((progress.fractionCompleted) * (100.00) / 1.0) , "%"  , " Total Count " , "100%")
            print("\(String(describing: progress.fileURL))")
            print()
        })
    }
    
func hitApiWithMultipleFile(requests : RequestFilesData , completion : @escaping BaseAPICompletion ) {
    
    var request = URLRequest(url: URL(string: requests.url)!)
    
    request.httpMethod = requests.method.rawValue
    
    let parameters = requests.parameters ?? [:]
    
    if requests.parameters != nil {
        do {
            request.httpBody = try? JSONSerialization.data(withJSONObject: requests.parameters ?? [:], options: .prettyPrinted)
        }
    }
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
//NetworkLogger.log(request: request)
    
    self.uploadRequest = AF.upload(multipartFormData: { multipart_FormData in
        
        for i in 0..<requests.numberOfFiles {
            
            multipart_FormData.append(requests.fileData[i], withName: requests.fileparam[i], fileName: requests.fileName[i], mimeType: requests.fileMimetype[i])
            
            for (key, value) in parameters {
                
                if let array = value as? [AnyObject] {
                    
                    for i in array {
                        multipart_FormData.append(String(describing: i).data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
                    /*   if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                     multipart_FormData.append(jsonData, withName: key as String)
                     _}
                     _            */
                    
                }else if let _ = value as? Parameters {
                    
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                        multipart_FormData.append(jsonData, withName: key as String)
                    }
                    
                } else {
                    multipart_FormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    
                }
                
            }
        }
        
        
    }, with: request).responseJSON { [weak self] (response) in
        
        //NetworkLogger.log(response: response.response ?? URLResponse())
        
        self?.serializedResponse(withResponse: response, clouser: { (receivedData, message, response) in
            completion(receivedData,message,response)
            self?.uploadRequest = nil
        })
    }
    
    self.uploadRequest?.uploadProgress(closure: { (progress) in
        print()
        print("Uploading Data " , ((progress.fractionCompleted) * (100.00) / 1.0) , "%"  , " Total Count " , "100%")
        print()
    })
}
    
    /**
     This is for get , post , patch , put type apis
     - getting data from internet
     - checking status code generated by alamofire
     */
    
//    func hitApi(requests : Request , completion : @escaping BaseAPICompletion ) {
//
//        var request = URLRequest(url: URL(string: requests.url)!)
//
//        request.httpMethod = requests.method.rawValue
//
//        request.allHTTPHeaderFields = requests.headers ?? [:]
//
//        if requests.parameters != nil {
//            defer{
//                print("------------- PARAMETERS---------------")
//            }
//            print("------------- PARAMETERS---------------")
//            print(requests.parameters)
//            do {
//                request.httpBody = try? JSONSerialization.data(withJSONObject: requests.parameters ?? [:], options: .prettyPrinted)
//            }
//        }
//
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        dump(request)
//
//        let task =  AF.request(request as URLRequestConvertible)
//
//        task.responseJSON { [weak self] (response) in
//
//            print(response)
//
//            self?.serializedResponse(withResponse: response, clouser: { (receivedData, message, response) in
//                completion(receivedData,message,response )
//            })
//        }
//    }
    
    func hitApi(requests : Request , completion : @escaping BaseAPICompletion ) {
        
        defer {
            print(requests.url)
            print(requests.parameters)
        }
        
        self.task =  AF.request(requests.url, method: requests.method, parameters: (requests.parameters ?? [:]), headers: (requests.headers ?? [:]))
                
        self.task?.responseJSON { [weak self] (response) in
            self?.serializedResponse(withResponse: response, clouser: { (receivedData, message, response) in
                if message?.lowercased().contains("expired token") ?? false{
                    NotificationCenter.default.post(name: .expiredToken, object: nil)
                }
                completion(receivedData,message,response)
                self?.task = nil
            })
        }
    }
    
    
    func hitApiWithJSONParams(requests : Request , completion : @escaping BaseAPICompletion ) {
        
        defer {
            print(requests.url)
            print(requests.parameters)
        }
        
        self.task =  AF.request(requests.url, method: requests.method, parameters: (requests.parameters ?? [:]), encoding: JSONEncoding.default,headers: (requests.headers ?? [:]))
                
        self.task?.responseJSON { [weak self] (response) in
            self?.serializedResponse(withResponse: response, clouser: { (receivedData, message, response) in
                if message?.lowercased().contains("expired token") ?? false{
                    NotificationCenter.default.post(name: .expiredToken, object: nil)
                }
                completion(receivedData,message,response)
                self?.task = nil
            })
        }
    }
    
    
    /**
     This function is used to return clouser of serialized response
     - take argument as dataresponse
     - return clouser
     */
    
    
    func serializedResponse(withResponse response: DataResponse<Any, AFError> , clouser: @escaping BaseAPICompletion) {
        
       // NetworkLogger.log(response: response.response ?? URLResponse())
        
        if response.response != nil {
            
            if let json = response.data {
                
                switch (response.response?.statusCode ?? -91) {
                    
                case 0...100 :
                    print("🤬 🤬 🤬 🤬 🤬 FAILED 🤬 🤬 🤬 🤬 🤬 ")
                    clouser(json, response.error?.localizedDescription , 0)
                    
                case 101...199 :
                    print("🤬 🤬 🤬 🤬 🤬 FAILED 🤬 🤬 🤬 🤬 🤬 ")
                    clouser(json, response.error?.localizedDescription, 0)
                    
                case 200...299:
                    
                    print(" 🎉 🎉 🎉 🎉 🎉 🎉 🍺 🍺 🍺 🍺 🍺 🍺")
                    switch response.result {
                    case .success(let data):
                        print(data)
                        clouser(data, response.description ,1)
                    case .failure(let error):
                        clouser(error, response.description ,0)
                    }
                    
                case 300...399:
                    print("🤬 🤬 🤬 🤬 🤬 FAILED 🤬 🤬 🤬 🤬 🤬 ")
                    clouser(json, response.description ,2)
                    
                case 400...412:
                    print("🤬 🤬 🤬 🤬 🤬 FAILED 🤬 🤬 🤬 🤬 🤬 ")
                    do{
                        clouser(json, ((try response.result.get() as? [String:Any])?["message"] as? String) ?? response.description ,2)
                    }
                    catch{
                        clouser(json, response.description ,2)
                    }
                    
                case 500...599:
                    clouser(json , "Database Error." , 2)
                    
                default :
                    print("🤬 🤬 🤬 🤬 🤬 FAILED 🤬 🤬 🤬 🤬 🤬 ")
                    clouser(json,response.description, 2)
                }
                print(response.description)
                
            }
            else {
                print("🤬 🤬 🤬 🤬 🤬 FAILED 🤬 🤬 🤬 🤬 🤬 ")
                clouser(nil,response.description, 2)
                print(response.description)
            }
        } else {
            print("🤬 🤬 🤬 🤬 🤬 FAILED 🤬 🤬 🤬 🤬 🤬 ")
            clouser(nil,"Could not connect to the server.", 2)
            print(response.description)
        }
    }
}


extension BaseAPI {
    
    public func synchronousDataTask(request : Request) -> SynchronousDataTaskResult {
        let semaphore = DispatchSemaphore(value: 0)
        
        var data: Data?
        var responses: URLResponse?
        var error: Error?
        
        let task = AF.request(request.url, method: request.method, parameters: request.parameters, encoding: JSONEncoding.default, headers: request.headers)
        
        task.responseData { (response) in
            data = response.data
            error = response.error
            responses = URLResponse(url: ((response.request?.url)!), mimeType: "", expectedContentLength: 0, textEncodingName: "default")
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, responses, error)
    }
}
