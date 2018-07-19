# ZestySwiftContentEndpointWrapper Template

The ZestySwiftContentEndpointWrapper makes it super easy to get data from your [Zesty.io](https://zesty.io) website.

1. [Installing ZestySwiftContentEndpointWrapper](#Installing-ZestySwiftContentEndpointWrapper)
2. [Usage](#Usage)
	- [initialization](#Initialization)
	- [Using Basic JSON API](#Using-Basic-JSON-API)
	- [Using Custom JSON Endpoints](#Using-Custom-JSON-Endpoints) 

## Installing ZestySwiftContentEndpointWrapper

ZestySwiftContentEndpointWrapper uses [Cocoapods](https://cocoapods.org).

Simply add

	pod 'ZestySwiftContentEndpointWrapper'
	pod 'SwiftyJSON' # required for custom JSON Endpoints

to your Podfile

## Usage

### Initialization


For example, creating a ZestyAPI Object for your website `http://burger.zesty.site`
    
     // Create the ZestyAPI Object
     let zesty = ZestySwiftContentEndpointWrapper(url: "http://burger.zesty.site")
    
- note: If your website does not have an SSL Certificate (HTTPS), you will need to configure your app to allow for non HTTPS Calls. [How to change this setting](https://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http)

### Using Basic JSON API

1. Enable the [Basic JSON API](https://developer.zesty.io/guides/api/basic-api-json-endpoints-guide/) in Config
2. Get the zuid for the item / array you are looking for
3. Use the according function (`getItem` or `getArray`)
   
Zuid Meanings and Functions to Use
    
- Any zuid that starts with a **6** is an array of items (use `getArray`)
- Any zuid that starts with a **7** is an object (use `getItem`)
    

#### Getting a Single Item
Gets a `[String : String]` json data for the specific zuid.
    
 You can find the zuid by looking at the **Content** Tab of Zesty.
 
    
 For example, getting a specific item with zuid `6-9bfe5c-ntqxrs`
    
     // Create the ZestyAPI Object
     let zesty = ZestySwiftContentEndpointWrapper(url: "http://burger.zesty.site")
     let zuid = "6-9bfe5c-ntqxrs"
    
     zesty.getItem(for: zuid, { (item) in
         print(item) // item is a [String : String] dictionary, in JSON Format
     }
#### Getting an Array
Gets a `[[String : String]]` array of json data for the specific zuid.
    
 You can find the zuid by looking at the **Content** Tab of Zesty.
 
    
 For example, getting a specific item with zuid `7-9bfe5c-ntqxrs`
    
	 // Create the ZestyAPI Object
	 let zesty = ZestySwiftContentEndpointWrapper(url: "http://burger.zesty.site")
	 let zuid = "7-9bfe5c-ntqxrs"
	    
	 zesty.getArray(for: zuid, { (items) in
	     for item in items {
	         print(item) // item is a [String : String] dictionary, in JSON Format
	     }
 	}

### Using Custom JSON Endpoints
Gets a [JSON](https://github.com/SwiftyJSON/SwiftyJSON#usage) object for the endpoint and parameters specified.

- note: ZestyAPI uses [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) to handle JSON objects. Make sure you add `pod 'SwiftyJSON'` to your `Podfile` in order to use the data returned.
- The returned JSON object's methods reference can be found [here](https://github.com/SwiftyJSON/SwiftyJSON#usage). 
- If you want to use a different type of JSON parsing, the raw data can be extracted from the JSON object using `json.rawString(options: [.castNilToNSNull: true])`. More information on extracting the raw JSON String can be found [here](https://github.com/SwiftyJSON/SwiftyJSON#user-content-string-representation)    
 
    
A full tutorial to create your own custom JSON Endpoints through the Zesty Interface can be found [here](https://developer.zesty.io/docs/code-editor/customizable-json-endpoints-for-content/)
    
    
#### Sample Usage
For example, using the custom endpoint `menulist` (Including the extension is only necessary for different file types ; .json is otherwise implied)
    
 
    
     // Create the ZestySwiftContentEndpointWrapper Object
     let zesty = ZestySwiftContentEndpointWrapper(url: "http://burger.zesty.site")
     let endpoint = "menulist"
     let parameters = ["location" : "San Diego"]
     getCustomData(from: endpoint, params: parameters, { (json) in
         print(item) // item is a [String : String] dictionary, in JSON Format
     }
     
Written by [@ronakdev](https://github.ronakshah.net)