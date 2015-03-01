//
//  User.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/19/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "CurrentUser"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var id: String?
    var name: String?
    var screenname: String?
    var profileImageURL: String?
    var tagline: String?
    var location: String?
    var profileBackgroundColor: String?
    var profileBackgroundImageUrlHttps: String?
    var profileBackgroundTile: String?
    var profileTextColor: String?
    var profileUseBackgroundImage: Bool?

    
    
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        id = dictionary["id_str"] as? String
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url_https"] as? String
        tagline = dictionary["description"] as? String
        location = dictionary["location"] as? String
        profileBackgroundColor = dictionary["profile_background_color"] as? String
        profileBackgroundImageUrlHttps = dictionary["profile_background_image_url_https"] as? String
        profileBackgroundTile = dictionary["profile_background_tile"] as? String
        profileTextColor = dictionary["profile_text_color"] as? String
        profileUseBackgroundImage = dictionary["profile_use_background_image"] as? Bool
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}
