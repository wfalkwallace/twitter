//
//  TweetsViewController.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/19/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource {

    var tweets: [Tweet]?
    @IBOutlet weak var tweetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetsTableView.dataSource = self
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, block: { (tweets, error) -> () in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
        })
    }

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.TweetCell") as TweetTableViewCell
        cell.tweetTextLabel.text = tweets?[indexPath.row].text
        return cell
    }
}
