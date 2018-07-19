//
//  DisplayViewController.swift
//  zesty-ios-swift-application-basic-example
//
//  Created by Ronak Shah on 7/16/18.
//  Copyright © 2018 Zesty.io. All rights reserved.
//

import UIKit
import WebKit

/// Displays a WebView with html from `DisplayViewController.htmlData`
class DisplayViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    /// Loaded in before instatiation
    var htmlData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.htmlData = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header><body>\(self.htmlData)</body>"
        self.webView.loadHTMLString(htmlData, baseURL: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
