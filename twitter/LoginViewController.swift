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
            (user: User?, error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier("com.falk-wallace.LoginSegue", sender: self)
            } else {
                //handle login error
            }
        }
        

    }

}

