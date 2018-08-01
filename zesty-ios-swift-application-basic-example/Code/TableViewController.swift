//
//  TableViewController.swift
//  zesty-ios-swift-application-basic-example
//
//  Created by Ronak Shah on 7/16/18.
//  Copyright © 2018 Zesty.io. All rights reserved.
//

import UIKit
import ZestySwiftContentEndpointWrapper
import SwiftyJSON

/// Provides a TableView to navigate through all the menus of [zesty-ios-swift-application-basic-example](http://burger.zesty.site)
class TableViewController: UITableViewController {

    var items: [String] = []
    var endpoint: String = "locationslist"
    var params: [String: String]! = nil
    var path = "/"
    var json: JSON!
    var api: ZestySwiftContentEndpointWrapper!
    
    /// Makes all the api calls
    /// note: api data should be set in instantiation by editing `TableViewController.endpoint`, `TableViewController.params`, and `TableViewController.path`
    override func viewDidLoad() {
        super.viewDidLoad()
    
        api = ZestySwiftContentEndpointWrapper(url: "https://6c706l48-dev.preview.zestyio.com")
        
        api.getCustomJSONData(from: self.endpoint, params: self.params) { (data, some) in
            if let error = some {
                // handle
                print(error.localizedDescription!)
                return
            }
            self.json = data
        
            switch(self.path) {
            case "/":
                self.items = ["About", "Locations", "Events", "Menu", "Blog", "Careers"]
                break
            case "/menu":
                self.items.append("@ESCAPING/: Food")
                self.items.append(contentsOf: Array(data["items"]["food"].dictionaryValue.keys))
                self.items.append("@ESCAPING/: Drink")
                self.items.append(contentsOf: Array(data["items"]["drink"].dictionaryValue.keys))
                self.json = data["items"]["food"].combine(with: data["items"]["drink"])
                break
            case "/blog":
                self.items = Array(data["posts"].dictionaryValue.keys)
                self.json = data["posts"]
                break
            case "/locations":
                self.items = data["locations"].arrayValue.map { $0.stringValue }
                break
            case "/locations/specificloc":
                self.items = ["Events", "Menu", "Careers"]
                break
            case "/locations/specificloc/menu":
                self.items = Array(data["items"].dictionaryValue.keys)
                self.json = data["items"]
                break
            case "/locations/specificloc/events", "/events":
                self.items = Array(data["events"].dictionaryValue.keys)
                self.json = data["events"]
                break
            case "/locations/specificloc/careers", "/careers":
                self.items = Array(data["careers"].dictionaryValue.keys)
                self.json = data["careers"]
                break
            default:
                break
            }
            
            
            self.tableView.reloadData()
        }
    }

    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default") as! DefaultTableViewCell
        let text = self.items[indexPath.row]
        if (text.contains("@ESCAPING/: ")) {
            let left = text.index(text.startIndex, offsetBy: 12)
            cell.label.text! = String(text[left..<text.endIndex])
            cell.selectionStyle = .none
            cell.accessoryType = .none
            cell.label.font = UIFont.boldSystemFont(ofSize: cell.label.font.pointSize)
            cell.header = true
        }
        else {
            cell.label.text! = self.items[indexPath.row]
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = (tableView.cellForRow(at: indexPath) as! DefaultTableViewCell)
        if cell.header {
            return
        }
        let text = cell.label.text!
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "tableVC") as! TableViewController
        
        switch(self.path) {
        case "/":
            if text.lowercased() == "about" {
                let realVC = self.storyboard!.instantiateViewController(withIdentifier: "displayVC") as! DisplayViewController
                api.getCustomJSONData(from: "aboutdata", params: nil) { (data, error) in
                    realVC.htmlData = data["content"].stringValue
                    self.navigationController?.pushViewController(realVC, animated: true)
                }
            }
            else {
                vc.path = "/\(text.lowercased())"
                vc.endpoint = "\(text.lowercased())list"
                vc.params = self.params
                self.navigationController?.pushViewController(vc, animated: true)
                vc.navigationItem.title! = "\(text)"
            }
            break
        case "/locations":
            vc.path = "/locations/specificloc"
            vc.endpoint = "menulist"
            vc.params = ["location" : text]
            
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.title! = "\(text)"
            break
        case "/locations/specificloc":
            vc.path = "/locations/specificloc/\(text.lowercased())"
            vc.endpoint = "\(text)list" //ie: eventslist || menulist || careerslist all with ?location=CITY NAME
            vc.params = self.params
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.title! = text
            
            break
        case "/locations/specificloc/events", "/locations/specificloc/careers", "/locations/specificloc/menu", "/events", "/careers", "/menu","/blog":
            let realVC = self.storyboard!.instantiateViewController(withIdentifier: "displayVC") as! DisplayViewController
            realVC.htmlData = json[text][( (self.path == "/blog") ? "content" : "description")].stringValue
            self.navigationController?.pushViewController(realVC, animated: true)
            break
        default:
            break
        }
    }
}
