//
//  MenuViewController.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/28/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuHeaderView: UIView!
    @IBOutlet weak var menuHeaderUsernameLabel: UILabel!
    @IBOutlet weak var menuHeaderProfileImage: UIImageView!
    @IBOutlet weak var menuTableView: UITableView!
    
    var menuItems = ["Profile", "Timeline", "Mentions"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var user = User.currentUser!
        menuHeaderUsernameLabel.text = user.screenname
        menuHeaderProfileImage.setImageWithURL(NSURL(string: user.profileImageURL!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.MenuItemCell") as MenuTableViewCell
//        cell.delegate = self
        return cell
    }

}
