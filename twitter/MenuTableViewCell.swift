//
//  MenuTableViewCell.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/28/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemName: UILabel!
    @IBOutlet weak var menuItemIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
