//
//  ViewController.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/17/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithBlock() {
            //go to next screen
        }
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "wfwtwitterapp://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
            println("failed to get the request token")
        }
    }

}

