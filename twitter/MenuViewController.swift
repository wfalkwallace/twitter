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
    @IBOutlet weak var menuHeaderRealNameLabel: UILabel!
    @IBOutlet weak var menuHeaderUsernameLabel: UILabel!
    @IBOutlet weak var menuHeaderProfileImage: UIImageView!
    @IBOutlet weak var menuTableView: UITableView!
    
    var menuItems = ["Profile", "Timeline", "Mentions"]
    let MENU_WIDTH:CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var user = User.currentUser!
        menuHeaderUsernameLabel.text = user.screenname
        menuHeaderProfileImage.setImageWithURL(NSURL(string: user.profileImageURL!))
        menuHeaderProfileImage.layer.cornerRadius = 10;
        menuHeaderProfileImage.clipsToBounds = true;
        
        menuTableView.reloadData()
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
        cell.menuItemName.text = menuItems[indexPath.row]
        cell.menuItemIcon.image = UIImage(named: "menu-" + menuItems[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
            let profileNavigationController = profileStoryboard.instantiateInitialViewController() as UINavigationController
            self.presentViewController(profileNavigationController, animated: true, completion: nil)
        } else if indexPath.row == 1 {
            let timelineStoryboard = UIStoryboard(name: "Timeline", bundle: nil)
            let timelineNav = timelineStoryboard.instantiateInitialViewController() as UINavigationController
            self.presentViewController(timelineNav, animated: true, completion: nil)
        } else if indexPath.row == 2 {
            let timelineStoryboard = UIStoryboard(name: "Timeline", bundle: nil)
            let timelineNav = timelineStoryboard.instantiateInitialViewController() as UINavigationController
            let timeline = timelineNav.viewControllers[0] as TimelineViewController
            timeline.mentions = true
            self.presentViewController(timelineNav, animated: true, completion: nil)
        }
    }

}
