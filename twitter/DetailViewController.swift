//
//  DetailViewController.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/22/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func detailViewController(detailViewController: DetailViewController,  didEndViewing: Bool)
}

class DetailViewController: UIViewController, ComposerViewControllerDelegate {

    var delegate: DetailViewControllerDelegate?
    var tweet: Tweet?
    
    @IBOutlet weak var tweetProfileImage: UIImageView!
    @IBOutlet weak var tweetName: UILabel!
    @IBOutlet weak var tweetUserName: UILabel!
    @IBOutlet weak var tweetTimestamp: UILabel!
    @IBOutlet weak var tweetRetweetUIView: UILabel!
    @IBOutlet weak var tweetRetweetUserName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetRetweetButton: UIButton!
    @IBOutlet weak var tweetRetweetCount: UILabel!
    @IBOutlet weak var tweetFavoriteButton: UIButton!
    @IBOutlet weak var tweetFavoriteCount: UILabel!
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        tweet?.retweeted = true
        tweet?.retweetCount! += 1
        TwitterClient.sharedInstance.retweetWithBlock(tweet!, block: { (tweet, error) -> () in
            if let tweet = tweet {
                self.tweetRetweetButton.setImage(UIImage(named: "retweet-on"), forState: .Normal)
            } else {
                println(error)
                // some error handling here
            }
        })
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        if let favorited = tweet?.favorited {
            tweet?.favorited = !favorited
            if !favorited {
                tweet?.favoriteCount! += 1
                TwitterClient.sharedInstance.favoriteWithBlock(tweet!, block: { (tweet, error) -> () in
                    if let tweet = tweet {
                        self.tweetFavoriteButton.setImage(UIImage(named: "favorite-on"), forState: .Normal)
                    } else {
                        println(error)
                        // some error handling here
                    }
                })
            } else {
                tweet?.favoriteCount! -= 1
                TwitterClient.sharedInstance.unFavoriteWithBlock(tweet!, block: { (tweet, error) -> () in
                    if let tweet = tweet {
                        self.tweetFavoriteButton.setImage(UIImage(named: "favorite"), forState: .Normal)
                    } else {
                        println(error)
                        // some error handling here
                    }
                })
            }
        }
    }

    @IBAction func onReply(sender: AnyObject) {
        let composerStoryboard = UIStoryboard(name: "Composer", bundle: nil)
        let composerNav = composerStoryboard.instantiateInitialViewController() as UINavigationController
        // This hack should move to CompNavCont subclass
        let composer = composerNav.viewControllers[0] as ComposerViewController
        composer.delegate = self
        self.presentViewController(composerNav, animated: true, completion: nil)
    }
    
    func composerViewController(composerViewController: ComposerViewController, didSendTweet tweet: Tweet?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        delegate?.detailViewController(self, didEndViewing: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetName.text = tweet!.user!.name
        tweetUserName.text = tweet!.user!.screenname
        tweetTimestamp.text = tweet!.formattedTimestamp
        tweetText.text = tweet!.text
        tweetProfileImage.setImageWithURL(NSURL(string: tweet!.user!.profileImageURL!))
        tweetRetweetCount.text = "\(tweet!.retweetCount)"
        tweetFavoriteCount.text = "\(tweet!.favoriteCount)"
        if let retweet = tweet!.retweetedStatus {
            tweetRetweetUserName.text = "Retweet of \(tweet!.retweetedStatus?.user!.screenname ?? String())"
            tweetRetweetUIView.hidden = false
        } else {
            tweetRetweetUIView.hidden = true
        }
        if tweet!.favorited! {
            tweetFavoriteButton.setImage(UIImage(named: "favorite-on"), forState: .Normal)
        }
        if tweet!.retweeted! {
            tweetRetweetButton.setImage(UIImage(named: "retweet-on"), forState: .Normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
