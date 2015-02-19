//
//  TwitterClient.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/19/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

let twitterConsumerKey = NSBundle.mainBundle().objectForInfoDictionaryKey("CONSUMER_KEY") as String
let twitterConsumerSecret = NSBundle.mainBundle().objectForInfoDictionaryKey("CONSUMER_SECRET") as String
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {

    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    
}
