//
//  ZestyAPITestsViewController.swift
//  ZestyBurger
//
//  Created by Ronak Shah on 7/17/18.
//  Copyright © 2018 Zesty.io. All rights reserved.
//

import UIKit

class ZestyAPITestsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.text = "Initializing Tests..."
        let api = ZestyAPI(url: "http://burger.zesty.site")
        
        // MARK: getItem tests
        // test 1
        api.getItem(for: "doesn't exist") { (data, error) in
            let text = "Testing getItem with zuid: doesn't exist"
            if error != nil {
                self.appendToTextView([text, error!])
            }
            else {
                self.appendToTextView([text, data])
            }
        }
        // test 2
        api.getItem(for: "7-6a1ece9-8bn013") { (data, error) in
            let text = "Testing getItem with zuid: 7-6a1ece9-8bn013"
            if error != nil {
                self.appendToTextView([text, error!])
            }
            else {
                self.appendToTextView([text, data])
            }
        }
        // test 3
        api.getItem(for: "6-ca7ed0-bx3vpj") { (data, error) in
            let text = "Testing getItem with zuid: 6-ca7ed0-bx3vpj"
            if error != nil {
                self.appendToTextView([text, error!])
            }
            else {
                self.appendToTextView([text, data])
            }
        }
        
        // MARK: getArray tests
        // test 1
        api.getArray(for: "doesn't exist") { (data, error) in
            let text = "Testing getArray with zuid: doesn't exist"
            if error != nil {
                self.appendToTextView([text, error!])
            }
            else {
                self.appendToTextView([text, data])
            }
        }
        // test 2
        api.getArray(for: "7-6a1ece9-8bn013") { (data, error) in
            let text = "Testing getArray with zuid: 7-6a1ece9-8bn013"
            if error != nil {
                self.appendToTextView([text, error!])
            }
            else {
                self.appendToTextView([text, data])
            }
        }
        // test 3
        api.getArray(for: "6-ca7ed0-bx3vpj") { (data, error) in
            let text = "Testing getArray with zuid: 6-ca7ed0-bx3vpj"
            if error != nil {
                self.appendToTextView([text, error!])
            }
            else {
                self.appendToTextView([text, data])
            }
        }
        
        // MARK: getCustomData tests
        // test 1
        var endpoint = "menulist"
        var params: [String:String]! = nil
        api.getCustomData(from: endpoint, params: params) { (data, error) in
            let text = "Testing getCustomData with endpoint \(endpoint) and params \(params)"
            if error != nil {
                self.appendToTextView([text, error!])
            }
            else {
                self.appendToTextView([text, data])
            }
        }
        // test 2
        endpoint = "menulist"
        params = ["location" : "San Diego"]
        api.getCustomData(from: endpoint, params: params) { (data, error) in
            let text = "Testing getCustomData with endpoint \(endpoint) and params \(params)"
            if error != nil {
                self.appendToTextView([text, error!])
            }
            else {
                self.appendToTextView([text, data])
            }
        }
        // test 3
        endpoint = "menulist"
        params = ["id" : "San Diego"]
        api.getCustomData(from: endpoint, params: params) { (data, error) in
            let text = "Testing getCustomData with endpoint \(endpoint) and params \(params)"
            if error != nil {
                self.appendToTextView([text, error!])
            }
            else {
                self.appendToTextView([text, data])
            }
        }
        // test 4
        endpoint = "sjfkldsjfsd"
        params = ["location" : "San Diego"]
        api.getCustomData(from: endpoint, params: params) { (data, error) in
            let text = "Testing getCustomData with endpoint \(endpoint) and params \(params)"
            if error != nil {
                self.appendToTextView([text, error!])
            }
            else {
                self.appendToTextView([text, data])
            }
        }
        // test 4
        endpoint = "event.ics"
        params = ["id" : "7-6a0c3ae-dz5cmr"]
        api.getCustomData(from: endpoint, params: params) { (data, error) in
            let text = "Testing getCustomData with endpoint \(endpoint) and params \(params)"
            if error != nil {
                self.appendToTextView([text, error!])
            }
            else {
                self.appendToTextView([text, data])
            }
        }
        
    }

    func appendToTextView(_ string: [Any]) {
        var text = ""
        string.forEach { (thing) in
            text = ("\n" + "\(string)")
        }
        self.textView.text = self.textView.text + text
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
