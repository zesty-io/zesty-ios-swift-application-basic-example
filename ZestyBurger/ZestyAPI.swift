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

/// ZestyAPI is a wrapper function used to get data from your [Zesty.io](https://zesty.io) website.
///
/// Functions:
/// ==========
///
/// `init(url: String)`
///
/// `func getItem(for zuid: String, completionHandler: @escaping (_ data: [String : String]) -> Void)`
///
/// `func getArray(for zuid: String, completionHandler: @escaping (_ data: [[String : String]]) -> Void)`
///
/// `func getCustomData(from endpoint: String, params: [String : String]!, completionHandler: @escaping (_ data: JSON) -> Void)`
///
///
/// - author: [@ronakdev](https://github.ronakshah.net)
/// - copyright: 2018 Zesty.io
class ZestyAPI {
    var baseURL: String

    /// Creates a `ZestyAPI` object for your website
    ///
    ///
    /// Sample Usage
    /// ==========
    ///
    /// Code
    /// ----
    ///
    /// For example, creating a ZestyAPI Object for your website `http://burger.zesty.site`
    ///
    ///     // Create the ZestyAPI Object
    ///     let api = Zesty(url: "http://burger.zesty.site")
    ///
    /// - note: If your website does not have an SSL Certificate (HTTPS), you will need to configure your app to allow for non HTTPS Calls. [How to change this setting](https://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http)
    /// - parameters:
    ///   - url: Your [Zesty.io](https://zesty.io) website
    init(url: String) {
        self.baseURL = url
    }
    
    /// Gets a [JSON](https://github.com/SwiftyJSON/SwiftyJSON#usage) object for the endpoint and parameters specified
    ///
    /// The endpoint is the name of the file that you created in Zesty
    ///
    /// A full tutorial to create your own custom JSON Endpoints can be found [here](https://developer.zesty.io/docs/code-editor/customizable-json-endpoints-for-content/)
    ///
    /// Sample Usage
    /// ==========
    ///
    /// Using the custom endpoint `menulist` (Including the extension is only necessary for different file types ; .json is otherwise implied)
    ///
    /// Code
    /// ----
    ///
    ///     // Create the ZestyAPI Object
    ///     let api = Zesty(url: "http://burger.zesty.site")
    ///     let endpoint = "menulist"
    ///     let parameters = ["location" : "San Diego"]
    ///     getCustomData(from: endpoint, params: parameters, { (json) in
    ///         print(item) // item is a [String : String] dictionary, in JSON Format
    ///     }
    /// - note: ZestyAPI uses [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) to handle JSON objects. The returned JSON object's methods reference can be found [here](https://github.com/SwiftyJSON/SwiftyJSON#usage). If you want to use a different type of JSON parsing, the raw data can be extracted from the JSON object using `json.rawString(options: [.castNilToNSNull: true])`. More information on extracting the raw JSON String can be found [here](https://github.com/SwiftyJSON/SwiftyJSON#user-content-string-representation)
    /// - parameters:
    ///   - endpoint: The endpoint string you are using. The extension is implied to be `.json` unless otherwise specified
    ///   - params: A Dictionary containing all the parameters. Use `nil` if there are no parameters
    ///   - completionHandler: Closure that handles the data once it is retrieved. If nothing is found, an empty array will be returned instead, and the error will be printed to the console.
    ///   - data: Returned through the closure, this is the [JSON](https://github.com/SwiftyJSON/SwiftyJSON#usage) object
    func getCustomData(from endpoint: String, params: [String : String]!, completionHandler: @escaping (_ data: JSON) -> Void) {
        var paramText = ""
        if (params != nil) {
            paramText = "?"
            paramText += params.map({ (key, value) -> String in
                return "\(key)=\(value)&"
            }).reduce("",+)
        }
        
        let urlString = "\(self.baseURL)/-/custom/\(endpoint)?\(paramText)"
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json)
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(JSON.null)
            }
        }
    }
    
    /// Gets a `[String : String]` json data for the specific zuid.
    ///
    /// You can find the zuid by looking at the *Content* Tab of Zesty.
    ///
    /// Zuid Meanings and Functions to Use
    ///
    /// - Any zuid that starts with a **6** is an array of items (use `getArray`)
    /// - Any zuid that starts with a **7** is an object (use `getItem`)
    ///
    /// Sample Usage
    /// ==========
    ///
    /// Code
    /// ----
    ///
    /// For example, getting a specific item with zuid `6-9bfe5c-ntqxrs`
    ///
    ///     // Create the ZestyAPI Object
    ///     let api = Zesty(url: "http://burger.zesty.site")
    ///     let zuid = "6-9bfe5c-ntqxrs"
    ///
    ///     api.getItem(for: zuid, { (item) in
    ///         print(item) // item is a [String : String] dictionary, in JSON Format
    ///     }
    /// - note: Using this function requires basic json endpoints to be [enabled](https://developer.zesty.io/guides/api/basic-api-json-endpoints-guide/).
    /// - parameters:
    ///   - zuid: The zuid for the item in question. It should start with a 7 when using this function
    ///   - completionHandler: Closure that handles the data once it is retrieved. If nothing is found, an empty array will be returned instead
    ///   - data: Returned through the closure, this is the [String : String] dictionary, in JSON Format
    func getItem(for zuid: String, completionHandler: @escaping (_ data: [String : String]) -> Void) {
        let urlString = "\(self.baseURL)/-/basic-content/\(zuid).json"
        let url = URL(string: urlString)!
        
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success((let value)):
                let json = JSON(value)
                if let stringJsonDict = json.dictionaryValue["data"] {
                    var stringStringDict = [String: String]()
                    stringJsonDict.forEach({ (key, valueJSON) in
                        stringStringDict[key] = valueJSON.stringValue
                    })
                    completionHandler(stringStringDict)
                }
                else {
                    // data incorrect shape. Go to <your_url>/-/basic-content/<zuid>.json to see if the json is loading properly. If the problem persists, contact support @ http://chat.zesty.io/
                    completionHandler([:])
                }
                
                break
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler([:])
                break
            }
        }
    }
    
    /// Gets a `[[String : String]]` array of json data for the specific zuid.
    ///
    /// You can find the zuid by looking at the *Content* Tab of Zesty.
    ///
    /// Zuid Meanings and Functions to Use
    ///
    /// - Any zuid that starts with a **6** is an array of items (use `getArray`)
    /// - Any zuid that starts with a **7** is an object (use `getItem`)
    ///
    /// Sample Usage
    /// ==========
    ///
    /// Code
    /// ----
    ///
    /// For example, getting a specific item with zuid `7-9bfe5c-ntqxrs`
    ///
    ///     // Create the ZestyAPI Object
    ///     let api = Zesty(url: "http://burger.zesty.site")
    ///     let zuid = "7-9bfe5c-ntqxrs"
    ///
    ///     api.getArray(for: zuid, { (items) in
    ///         for item in items {
    ///             print(item) // item is a [String : String] dictionary, in JSON Format
    ///         }
    ///     }
    ///
    /// - parameters:
    ///   - zuid: The zuid for the item in question. It should start with a 6 when using this function
    ///   - completionHandler: Closure that handles the data once it is retrieved. If nothing is found, an empty array will be returned instead
    ///   - data: Returned through the closure, this is the [[String : String]] array of dictionaries
    func getArray(for zuid: String, completionHandler: @escaping (_ data : [[String : String]]) -> Void) {
        let urlString = "\(self.baseURL)/-/basic-content/\(zuid).json"
        let url = URL(string: urlString)!
        
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success((let value)):
                let json = JSON(value)
                //json["data"].arrayValue // list of dictionaries
                let stringJsonDictArray = json["data"].arrayValue
                var stringStringDictArray = [[String: String]]()
                stringJsonDictArray.forEach({ (stringJsonDict) in
                    var stringStringDict = [String: String]()
                    stringJsonDict.forEach({ (key, valueJSON) in
                        stringStringDict[key] = valueJSON.stringValue
                    })
                    stringStringDictArray.append(stringStringDict)
                })
                
                // now we have an array of dictionaries, with multiple versions per value.
                var d: [String : [String : String]] = [:]
                for dict in stringStringDictArray {
                    let zuid = dict["_item_zuid"]!
                    let version = dict["_version"]!
                    print("Zuid: \(dict["_item_zuid"]!)")
                    print("Version: \(dict["_version"]!)")
                    if let val = d[zuid] {
                        // val is the [String : String] obj itself
                        if Int(val["_version"]!)! < Int(version)! { // if this new thing is a later version
                            d[zuid] = dict // update it
                        }
                    }
                    else {
                        d[zuid] = dict // initial placement of the zuid
                    }
                }
                let toReturn = Array(d.values)
                completionHandler(toReturn)
                break
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler([[:]])
                break
            }
        }
    }

}
