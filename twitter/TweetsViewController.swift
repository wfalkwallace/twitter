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
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 89

        tweetsTableView.addPullToRefreshWithActionHandler { () -> Void in
            TwitterClient.sharedInstance.homeTimelineWithParams(nil, block: { (tweets, error) -> () in
                self.tweets = tweets
                self.tweetsTableView.reloadData()
                // hack to fix initial load rowheights
                self.tweetsTableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, self.tweetsTableView.numberOfSections())), withRowAnimation: .None)
                self.tweetsTableView.pullToRefreshView.stopAnimating()
            })
        }
        
        
        tweetsTableView.addInfiniteScrollingWithActionHandler { () -> Void in
            var params = [:]
            if let maxId = self.tweets?.last?.id {
                params = ["max_id": "\(maxId + 1)"]
            }
            TwitterClient.sharedInstance.homeTimelineWithParams(params, block: { (tweets, error) -> () in
                self.tweets? += tweets!
                self.tweetsTableView.infiniteScrollingView.stopAnimating()
                self.tweetsTableView.reloadData()
            })
        }
        
        tweetsTableView.triggerPullToRefresh()
    }

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweets?[indexPath.row].retweetedStatus?.user!.screenname != nil
            ? tweetsTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.RetweetCell") as TweetTableViewCell
            : tweetsTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.TweetCell") as TweetTableViewCell
        cell.tweet = tweets?[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
