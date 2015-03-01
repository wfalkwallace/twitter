//
//  ProfileViewController.swift
//  twitter
//
//  Created by William Falk-Wallace on 3/1/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User?
    var tweets: [Tweet]?
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var bannerScrollView: UIScrollView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    @IBOutlet weak var profileImage: UIScrollView!
    @IBOutlet weak var realNameLabel: UIScrollView!
    @IBOutlet weak var usernameLabel: UIScrollView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var tweetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
