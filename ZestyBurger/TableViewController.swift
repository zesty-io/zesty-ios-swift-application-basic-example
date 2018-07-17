//
//  TableViewController.swift
//  ZestyBurger
//
//  Created by Ronak Shah on 7/16/18.
//  Copyright © 2018 Zesty.io. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewController: UITableViewController {

    var items: [String] = []
    var endpoint: String = "locationslist"
    var params: [String: String]! = nil
    var path = "/"
    var json: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let api = ZestyAPI(url: "https://6c706l48-dev.preview.zestyio.com")
        api.getData(from: self.endpoint, params: self.params) { (data, err) in
            if (err == nil) {
                self.json = data
                if (self.path == "/") {
                    self.items = ["About", "Locations", "Events", "Menu", "Blog", "Careers"]
                }
                else if (self.path == "/locations") {
                    self.items = data["locations"].arrayValue.map { $0.stringValue }
                }
                else if (self.path == "/locations/specificloc") {
                    self.items = ["Events", "Menu", "Careers"]
                }
                else if (self.path == "/locations/specificloc/menu") {
                    self.items = Array(data["items"].dictionaryValue.keys)
                    self.json = data["items"]
                }
                else if (self.path == "/locations/specificloc/events") {
                    self.items = Array(data["events"].dictionaryValue.keys)
                    self.json = data["events"]
                }
                else if (self.path == "/locations/specificloc/careers") {
                    self.items = Array(data["careers"].dictionaryValue.keys)
                    self.json = data["careers"]
                }
                self.tableView.reloadData()
            }
            else {
                print(err!.localizedDescription)
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default") as! DefaultTableViewCell
        
        cell.label.text! = self.items[indexPath.row]

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = (tableView.cellForRow(at: indexPath) as! DefaultTableViewCell).label.text!
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "tableVC") as! TableViewController
        
        switch(self.path) {
        case "/":
            vc.path = "/\(text.lowercased())"
            vc.endpoint = "\(text.lowercased())list"
            vc.params = self.params
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.title! = "\(text)"
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
        case "/locations/specificloc/events", "/locations/specificloc/careers", "/locations/specificloc/menu":
            let realVC = self.storyboard!.instantiateViewController(withIdentifier: "displayVC") as! DisplayViewController
            realVC.htmlData = json[text]["description"].stringValue
            self.navigationController?.pushViewController(realVC, animated: true)
//            realVC.navigationItem.title! = text
            break
        default:
            break
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
