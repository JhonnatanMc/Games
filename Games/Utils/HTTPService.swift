//
//  HTTPService.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Foundation


//
//  HTTPService.swift
//  Koombea
//
//  Created by Jhonnatan Macias on 6/18/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Alamofire
import Foundation

open class HTTPService {
    
    class func get(_ entryPoint : String, successCallback : @escaping (Data?, Int) -> Void) -> Void {
        
        let headers = [
            "X-Parse-Application-Id": "I9pG8SLhTzFA0ImFkXsEvQfXMYyn0MgDBNg10Aps",
            "X-Parse-REST-API-Key": "Yvd2eK2LODfwVmkjQVNzFXwd3N0X7oUuwiMI3VDZ"
        ]
        
        Alamofire.request(Environment.BASE_URL + entryPoint, method: .get, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            
            print(response.request!)  // original URL request
            print(response.response!) // URL response
            print(response.data!)     // server data
            print(response.result)   // result of response serialization
            if let responseString = String(data: response.data!, encoding: .utf8) {
                print("raw response: \(responseString)")
            }
            
            if response.response?.statusCode == nil{
                successCallback(nil, 0)
            }else{
                if response.response?.statusCode == 200 && response.data != nil{
                    successCallback(response.data!, 200)
                } else {
                    if response.response?.statusCode == 400 && response.data != nil{
                        successCallback(response.data!, 400)
                    } else {
                        if response.response?.statusCode == 404 && response.data != nil{
                            successCallback(response.data!, 404)
                        } else {
                            if response.response?.statusCode == 403 && response.data != nil{
                                successCallback(nil, response.response!.statusCode)
                            }else{
                                if(response.response?.statusCode == 410){
                                    successCallback(nil, response.response!.statusCode)
                                }else {
                                    successCallback(response.data, response.response!.statusCode)
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}
