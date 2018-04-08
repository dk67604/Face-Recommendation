//
//  FaceAPI.swift
//  CustomCamera
//
//  Created by Rakesh Bhavsar on 4/8/18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */

import UIKit

enum FaceAPIResult<T, Error> {
    case Success(T)
    case Failure(Error)
}

class FaceAPI: NSObject {
    
    
    
    
    // Upload face
    static func uploadFace(faceImage: UIImage, completion: @escaping (_ result: FaceAPIResult<String, Error>) -> Void) {
        
        let url = "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=age,gender"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        
        request.httpMethod = "POST"
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.setValue("8b458d61dc6a49f2820e317d3b018b15", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let pngRepresentation = UIImagePNGRepresentation(faceImage)
        
        let task = URLSession.shared.uploadTask(with: request as URLRequest, from: pngRepresentation) { (data, response, error) in
            
            if error != nil {
                print("Error")
            }
            else {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                do {
                    _ = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    if statusCode == 200 {
                        print("Success")
                    }
                }
                catch {
                    print("Error")
                }
            }
        }
        task.resume()
    }
    
    
    
    
 
}

