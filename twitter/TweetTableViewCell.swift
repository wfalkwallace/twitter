//
//  TweetTableViewCell.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/19/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet: Tweet? {
        didSet {
            tweetNameLabel.text = tweet!.user!.name
            tweetScreennameLabel.text = tweet!.user!.screenname
            tweetTimestampLabel.text = tweet!.createdAtString
            tweetTextLabel.text = tweet!.text
            tweetProfileImageURL.setImageWithURL(NSURL(string: tweet!.user!.profileImageURL!))
        }
    }
    
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var tweetScreennameLabel: UILabel!
    @IBOutlet weak var tweetTimestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetProfileImageURL: UIImageView!
    @IBOutlet weak var tweetRetweetLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
