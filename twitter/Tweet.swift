//
//  Tweet.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/19/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var formattedTimestamp: String {
        if let elapsedTimeInSeconds = createdAt?.timeIntervalSinceNow {
            var elapsedTimeInHours = elapsedTimeInSeconds / 3600.0
            var elapsedTimeInDays = elapsedTimeInHours / 24.0
            return elapsedTimeInDays > 1
                   ? "\(abs(Int(elapsedTimeInDays)))d"
                   : elapsedTimeInHours > 1
                     ? "\(abs(Int(elapsedTimeInHours)))h"
                     : "\(abs(Int(elapsedTimeInSeconds / 60.0)))m"
        } else {
            return "??h"
        }
    }
    var favoriteCount: Int?;
    var favorited: Bool?;
    var retweetCount: Int?;
    var retweeted: Bool?;

    var retweetedStatus: Tweet?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        favoriteCount = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as? Int
        retweeted = dictionary["retweeted"] as? Bool
        if let originalTweet = dictionary["retweeted_status"] as? NSDictionary {
            retweetedStatus = Tweet(dictionary: originalTweet)
        }
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
