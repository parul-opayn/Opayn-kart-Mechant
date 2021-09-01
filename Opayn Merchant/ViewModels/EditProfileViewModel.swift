//
//  EditProfileViewModel.swift
//  OpaynKart
//
//  Created by OPAYN on 23/08/21.
//

import Foundation

class EditProfileViewModel: BaseAPI {
    
    func editProfile(imageName:String,imageData:Data,imageMimeType:String,userName:String,userId:String,completion:@escaping(Bool,String)->()){
        let  param  = ["name":userName, "id": userId] as baseParameters
        let fileRequest = RequestFileData(url: (URLS.baseUrl, APISuffix.updateUser), method: .post, parameters: param, headers: true, fileData: imageData, fileName: imageName, fileMimetype: imageMimeType, fileParam: "file")
        
        super.hitApiWithSingleFile(requests: fileRequest) { receivedData, message, responseCode in
            if responseCode == 1{
                if let data = receivedData as? [String:Any]{
                    print(data)
                    completion(true,message ?? "")
                }
                else{
                    completion(false,message ?? "")
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
        
    }
    
}
