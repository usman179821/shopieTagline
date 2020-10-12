//
//  Networking.swift
//  HailLu
//
//  Created by Macbook on 29/01/2020.
//  Copyright © 2020 HaiLuTec. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Networking {
    static let instance = Networking()
    
    //Calling Listing Api
    func listingApiCall(url:String,param:[String:Any]?,ImagesArray : [UIImage] ,completionHandler: @escaping (_ Response:JSON,_ Error:String?, _ StatusCode: Int) -> ()) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            var imagesData : [Data] = []
            for _image in ImagesArray{
                if let data: Data = (_image as UIImage).jpegData(compressionQuality: 0.9) {
                    imagesData.append(data)
                }
            }
            for i in 0..<imagesData.count{
                multipartFormData.append(imagesData[i], withName: "fileToUpload", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
        }, to:url,method: .post,headers: nil){ (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    let progress = Int(progress.fractionCompleted * 100)
                    print("progess == \(progress)")
                })
                upload.responseJSON { response in
                    let statusCode = response.response?.statusCode
                    guard let data = response.data else {return}
                    print(data)
                    completionHandler(JSON(data),nil, statusCode ?? -1)
                }
                
            case .failure(let error):
                //print encodingError.description
                completionHandler(JSON(error),error.localizedDescription, 500)
                break
            }
        }
    }
    
}


