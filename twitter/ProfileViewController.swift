//
//  ProfileViewController.swift
//  twitter
//
//  Created by William Falk-Wallace on 3/1/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, ComposerViewControllerDelegate, DetailViewControllerDelegate, UITableViewDelegate, TweetTableViewCellDelegate {

    var user: User?
    var tweets: [Tweet]?
    
    @IBOutlet var containerView: UIView!
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
    
    var menuViewController: MenuViewController!
    var profileViewController: ProfileViewController!
    var menuOriginX: CGFloat!
    var menuWidth: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
        
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        profileViewController = profileStoryboard.instantiateViewControllerWithIdentifier("ProfileViewController") as ProfileViewController
        profileViewController.view.frame = containerView.frame

        let menuStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        menuViewController = menuStoryboard.instantiateViewControllerWithIdentifier("MenuViewController") as MenuViewController
        menuWidth = 200
        menuOriginX = -menuWidth
        menuViewController.view.frame = CGRect(x: menuOriginX, y: 0, width: menuWidth, height: containerView.frame.height)
        containerView.addSubview(menuViewController.view)
    
    }
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(self.view)
        let translation = sender.translationInView(self.view)
        let velocity = sender.velocityInView(self.view)
        
        if sender.state == UIGestureRecognizerState.Began {
        } else if sender.state == UIGestureRecognizerState.Changed {
            let menuTranslation = menuOriginX + translation.x
            let profileTranslation = menuWidth + menuTranslation
            menuViewController.view.frame.origin.x = menuTranslation < -menuWidth ? -menuWidth : menuTranslation > 0 ? 0 : menuTranslation
            containerScrollView.frame.origin.x = profileTranslation < 0 ? 0 : profileTranslation > menuWidth ? menuWidth : profileTranslation
        } else if sender.state == UIGestureRecognizerState.Ended {
            if velocity.x > 0 {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.menuViewController.view.frame.origin.x = 0
                    self.containerScrollView.frame.origin.x = self.menuWidth
                })
            } else {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.frame.origin.x = -self.menuWidth
                    self.containerScrollView.frame.origin.x = 0
                })
            }
            menuOriginX = menuViewController.view.frame.origin.x
        }
    }
    
    func setupTable() {
        let myMenuStoryboard = UIStoryboard(name: "Menu", bundle: nil)
        menuViewController = myMenuStoryboard.instantiateViewControllerWithIdentifier("Profile") as MenuViewController

        
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        
        let nib = UINib(nibName: "TweetTableViewCell", bundle: NSBundle.mainBundle())
        tweetsTableView.registerNib(nib, forCellReuseIdentifier: "com.falk-wallace.TweetCell")
        
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 120
        
        tweetsTableView.addPullToRefreshWithActionHandler { () -> Void in
            TwitterClient.sharedInstance.homeTimelineWithParams(nil, block: { (tweets, error) -> () in
                self.tweets = tweets
                self.tweetsTableView.reloadData()
                self.tweetsTableView.pullToRefreshView.stopAnimating()
            })
        }
        
        //        tweetsTableView.addInfiniteScrollingWithActionHandler { () -> Void in
        //            var params = [:]
        //            if let maxId = self.tweets?.last?.id {
        //                params = ["max_id": "\(maxId + 1)"]
        //            }
        //            TwitterClient.sharedInstance.homeTimelineWithParams(params, block: { (tweets, error) -> () in
        //                self.tweets? += tweets!
        //                self.tweetsTableView.infiniteScrollingView.stopAnimating()
        //                self.tweetsTableView.reloadData()
        //            })
        //        }
        
        tweetsTableView.triggerPullToRefresh()
    }
    
    func tweetTableViewCell(tweetTableViewCell: TweetTableViewCell, replyTo tweet: Tweet?) {
        let composerStoryboard = UIStoryboard(name: "Composer", bundle: nil)
        let composerNav = composerStoryboard.instantiateInitialViewController() as UINavigationController
        // This hack should move to CompNavCont subclass
        let composer = composerNav.viewControllers[0] as ComposerViewController
        composer.reply = tweet
        composer.delegate = self
        self.presentViewController(composerNav, animated: true, completion: nil)
    }
    
    @IBAction func onCompose(sender: AnyObject) {
        let composerStoryboard = UIStoryboard(name: "Composer", bundle: nil)
        let composerNav = composerStoryboard.instantiateInitialViewController() as UINavigationController
        // This hack should move to CompNavCont subclass
        let composer = composerNav.viewControllers[0] as ComposerViewController
        composer.delegate = self
        self.presentViewController(composerNav, animated: true, completion: nil)
    }
    
    func composerViewController(composerViewController: ComposerViewController, didSendTweet tweet: Tweet?) {
        if let tweet = tweet {
            tweets?.insert(tweet, atIndex: 0)
            tweetsTableView.reloadData()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func detailViewController(detailViewController: DetailViewController, didEndViewing: Bool) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.TweetCell") as TweetTableViewCell
        cell.tweet = tweets?[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailNav = detailStoryboard.instantiateInitialViewController() as UINavigationController
        // This hack should move to CompNavCont subclass
        let detail = detailNav.viewControllers[0] as DetailViewController
        detail.delegate = self
        detail.tweet = tweets![indexPath.row]
        self.presentViewController(detailNav, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
