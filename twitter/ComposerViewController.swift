//
//  ComposerViewController.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/20/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

protocol ComposerViewControllerDelegate: class {
    func composerViewController(composerViewController: ComposerViewController,  didSendTweet tweet: Tweet?)
}

class ComposerViewController: UIViewController {

    @IBOutlet weak var composerUserImage: UIImageView!
    @IBOutlet weak var composerName: UILabel!
    @IBOutlet weak var composerUsername: UILabel!
    @IBOutlet weak var composerCharacterCount: UILabel!
    @IBOutlet weak var composerTextField: UITextField!
    
    
    var delegate: ComposerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(sender: AnyObject) {
        // TODO
        var tweet = Tweet(text: composerTextField.text, user: User.currentUser!)
//        TwitterClient.sharedInstance.updateStatus(tweet)
        delegate?.composerViewController(self, didSendTweet: tweet)
    }

    @IBAction func onCancel(sender: AnyObject) {
        delegate?.composerViewController(self, didSendTweet: nil)
    }

}
