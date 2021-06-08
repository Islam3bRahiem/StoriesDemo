//
//  API.swift
//  StoriesDemo
//
//  Created by Islam 3bRahiem on 3/24/20.
//  Copyright © 2020 Organization. All rights reserved.
//

import Foundation

import Foundation
import Alamofire


enum ErrorCode:Int {
    case Caneled = -999
    case NoInternet = -1009
    case UnKnown = 000
}

enum StatusCode:Int {
    case Success = 200
    case Failed = 401
    case ExpiredJWT = 403
}


typealias errorType = (ErrorCode, Any?) -> ()
typealias errorCompletionType = ((ErrorCode?)->())

class APIManager {
    
    func contectToApiWith(url : String , methodType : HTTPMethod ,params : [String:Any]?, success: @escaping (Any) -> (), errorHandler: @ escaping errorType ) {
        
        let HEADER = ["lang": "en",
                      "Jwt": "tp7oZ6MY54HHm1Ub3tEYfsE0J1581493451"]
        
        print("$ URL:", url)
        
        if params != nil {
            print("$Param:", params!)
        }
        
        Alamofire.request(url,
                          method: methodType,
                          parameters: params,
                          encoding: URLEncoding.default, headers: HEADER).validate().responseJSON{ response in
                            if response.result.error != nil {
                                if let errorCodeValue = response.error?._code,
                                    let errorCode = ErrorCode(rawValue: errorCodeValue){
                                    errorHandler(errorCode, response.error)
                                } else {
                                    errorHandler(ErrorCode.UnKnown, response.error)
                                }
                                return
                            }
                            
                            if response.data?.count == 0 {
                                errorHandler(ErrorCode.UnKnown, "No Data Retrived")
                                return
                            }
                            if let responseValue = response.value {
                                success(responseValue)
                                print("Response:", responseValue)
                            }
        }
        
        
    }
}




class HomeAPI {
    
    private let apiManager = APIManager()
    private let decoder = JSONDecoder()
    typealias model = (HomeResponseModel)->()
    
    func getHomeData( didDataReady: @escaping model) {
        
        apiManager.contectToApiWith(url: "https://moon-iet.com/api/services?country_id=1",
                                    methodType: .get,
                                    params: nil,
                                    success: { (json) in
                                        
            if let data = try? JSONSerialization.data(withJSONObject: json) {
                do {
                    let result = try self.decoder.decode(HomeResponseModel.self, from: data)
                    didDataReady(result)
                }catch{
                    print("error\(error)")
                }
                
            }
        }) { (error, msg) in
            print(error, msg!)
        }
    }
    
}
