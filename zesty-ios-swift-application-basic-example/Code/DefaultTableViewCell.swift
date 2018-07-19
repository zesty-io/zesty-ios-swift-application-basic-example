//
//  DefaultTableViewCell.swift
//  zesty-ios-swift-application-basic-example
//
//  Created by Ronak Shah on 7/16/18.
//  Copyright © 2018 Zesty.io. All rights reserved.
//

import UIKit

/// Displays a single UILabel
class DefaultTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    var header: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
