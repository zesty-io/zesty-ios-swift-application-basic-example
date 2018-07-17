//
//  ZestyAPI.swift
//  ZestyBurger
//
//  Created by Ronak Shah on 7/16/18.
//  Copyright © 2018 Zesty.io. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ZestyAPI {
    var baseURL: String
    
    init(url: String) {
        self.baseURL = url
    }
    
    func getData(from endpoint: String, params: [String : String]!, completionHandler: @escaping (JSON, Error?) -> Void) {
        var paramText = ""
        if (params != nil) {
            paramText = "?"
            paramText += params.map({ (key, value) -> String in
                return "\(key)=\(value)&"
            }).reduce("",+)
        }
        
        let urlString = "\(self.baseURL)/-/custom/\(endpoint)\(paramText)"
        print(urlString)
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json, nil)
            case .failure(let error):
                completionHandler(JSON.null, error)
            }
        }
    }
}
